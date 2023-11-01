%%%Calculate mutual information%%%
%
% Usage: [MI R PDF PMI PR] = mutualinfo(W,V,r,lag,gpumode,nshuf)
%
% MI      - Output MI array
% R       - Output correlation coefficient array.
% PDF     - Output PDF arrays (of W (Y), V (X), and W*V (XY)).
% PMI     - Probability of MI over data shuffles.
% PR      - Probability of R over data shuffles.
% r       - number of bins
% lag     - number of time shifts
% W       - information channel by time (source)
% V       - information channel by time (destination)
% gpumode - GPU mode flag 0 = 'no', 1 = 'yes'.
% nshuf   - Integer no. of shuffles to apply and test against (0: no shuffling).
%
% Nb: W and V must be of the same size,2-D.
% Nb: Entry data variables should be doubles.
%
% 2018/12/06: Created by Hung, H.Y. to use Gaussian kernel density est.
% 2019/08/30: Modified by Josh Goh to handle arrays (parallel channels).
% 2020/04/06: Modified by Josh Goh to also output PDFs.
% 2020/04/23: Modified by Josh Goh to incorporate switch gpu modes.
% 2020/04/23: Modified by Josh Goh to handle vector data (non-arrays).
% 2020/04/30: Modified by Josh Goh to also output R.
% 2020/05/03: Modified by Josh Goh to apply data shuffling test of probability.
%%%

% Main control level function to switch gpu modes.
function [MI R PDF PMI PR] = mutualinfo(W,V,r,lag,gpumode,nshuf)

	% Handle GPU contingency
	if gpumode == 1
		arraymode = 'gpuArray';
		W = gpuArray(W);
		V = gpuArray(V);
	else
		arraymode = 1;
	end

	series_length = size(W,2);
	MI    = zeros(size(W,1),lag+1,arraymode);
	R     = zeros(size(W,1),lag+1,arraymode);
	pdfX  = zeros(size(W,1),r,lag+1,arraymode);
	pdfY  = zeros(size(W,1),r,lag+1,arraymode);
	pdfXY = zeros(size(W,1),r,r,lag+1,arraymode);

	% Compute MI
	[MI R pdfX pdfY pdfXY] = gkde_mi(W,V,r,lag,MI,R,pdfX,pdfY,pdfXY,series_length,arraymode);
	[MI,R,PDF.X,PDF.Y,PDF.XY] = gather(MI,R,pdfX,pdfY,pdfXY);

	% Shuffling MI comparison
	if nshuf > 0
		tMI    = zeros(size(W,1),1,arraymode);
		tR     = zeros(size(W,1),1,arraymode);
		tpdfX  = zeros(size(W,1),r,1,arraymode);
		tpdfY  = zeros(size(W,1),r,1,arraymode);
		tpdfXY = zeros(size(W,1),r,r,1,arraymode);
		sMI    = zeros(size(W,1),nshuf,arraymode);
		sR     = zeros(size(W,1),nshuf,arraymode);

		for s = 1:nshuf
			[~,si] = sort(rand(1,size(W,2)));
			[sMI(:,s) sR(:,s)] = gkde_mi(W(:,si),V,r,0,tMI,tR,tpdfX,tpdfY,tpdfXY,series_length,arraymode);
		end
		[sMI sR] = gather(sMI,sR);

		% Compute p(MI > sMI) and p(R ~= sR)
		for t = 1:lag+1,
			PMI(:,t) = 1 - sum(MI(:,t) > sMI,2)./nshuf;
			PR(:,t)  = 1 - sum([R(R(:,t)<0,t)<sR(R(:,t)<0,:); R(R(:,t)>0,t)>sR(R(:,t)>0,:)],2)./nshuf;
		end

	end % End shuffling

end % EOF MI

% Sub-functions
% Gaussian kernel density estimation
function [MI R pdfX pdfY pdfXY] = gkde_mi(W,V,r,lag,MI,R,pdfX,pdfY,pdfXY,series_length,arraymode);

	b = 0;
	for tlag = 0:1:lag

		% Preliminary parameters
		b   = b + 1;
		X   = [V(:,1+tlag:(series_length-lag)+tlag)];
		Y   = [W(:,1:(series_length-lag))];
		XY  = cat(3,X,Y);
		n   = size(X,2);
		d   = 1;
		dxy = 2;
		h   = (4/(d+2))^(1/(d+4))*(n^((-1)/(d+4)));
		hxy = (4/(dxy+2))^(1/(dxy+4))*(n^((-1)/(dxy+4)));
		rX  = (max(X') - min(X'))'./r;
		rY  = (max(Y') - min(Y'))'./r;
		dX  = (max(X')' - min(X')' - rX)./rX;
		dY  = (max(Y')' - min(Y')' - rY)./rY;
		uX  = min(X')' + rX./2 + repmat(0:dX(1),size(rX,1),1).*rX;
		uY  = min(Y')' + rY./2 + repmat(0:dY(1),size(rY,1),1).*rY;
		if size(uX,2)==(r - 1), uX(:,r) = max(X')' - rX./2;	end
		if size(uY,2)==(r - 1),	uY(:,r) = max(Y')' - rY./2;	end
		uXY = cat(3,uX,uY);
		EX  = sum(X,2)./size(X,2);
		EY  = sum(Y,2)./size(Y,2);
		SX  = sum((X - EX).^2,2)./(size(X,2)-1); % Scalar
		SY  = sum((Y - EY).^2,2)./(size(Y,2)-1); % Scalar
		sXY = sum((X - EX).*(Y - EY),2)./(size(X,2)-1);
		SXY = cat(3,[SX sXY],[sXY SY]); % 2 x 2 Matrix
		detSXY = SXY(:,1,1).*SXY(:,2,2)-SXY(:,1,2).*SXY(:,2,1);
		C      = cat(3,[SXY(:,2,2) -SXY(:,1,2)],[-SXY(:,2,1) SXY(:,1,1)]);
		iSXY   = bsxfun(@times,1./detSXY,C); % 1./detSXY.*C

		% Set PDF place holders
		PX  = zeros(size(X,1),r,arraymode);
		PY  = zeros(size(Y,1),r,arraymode);
		PXY = zeros(size(X,1),r,r,arraymode);

		% Compute PDFs looping over bins
		for i = 1 : r
			uXX     = (uX(:,i)-X).*(SX.^-1).*(uX(:,i)-X)./(h^2);
			KX      = exp(-uXX./2)./((2*pi).^(d/2)*h^d*(SX.^0.5));
			PX(:,i) = sum(KX./n.*rX,2);
			uYY     = (uY(:,i)-Y).*(SY.^-1).*(uY(:,i)-Y)./(h^2);
			KY      = exp(-uYY./2)./((2*pi).^(d/2)*h^d*(SY.^0.5));
			PY(:,i) = sum(KY./n.*rY,2);
			for j = 1:r
				duXY       = [uXY(:,i,1) uXY(:,j,2)] - permute(XY,[1,3,2]);
				uuXYXY     = permute(cat(4,sum(duXY.*iSXY(:,:,1),2),sum(duXY.*iSXY(:,:,2),2)),[1,2,4,3]);
				uXYXY      = sum(squeeze(uuXYXY(:,1,:,:)).*squeeze(duXY)./(hxy^2),length(size(squeeze(uuXYXY(:,1,:,:))))-1);
				KXY        = exp(-uXYXY./2)./((2*pi).^(dxy/2)*hxy^dxy*(detSXY.^0.5));
				PXY(:,i,j) = sum(KXY./n.*rX.*rY,length(size(squeeze(uuXYXY(:,1,:,:)))));
			end
		end
		PX  = PX./sum(PX,2);
		PY  = PY./sum(PY,2);
		PXY = bsxfun(@times,PXY,1./sum(sum(PXY,3),2));
		PXY(isnan(PXY)) = 0;
		pdfX(:,:,b) = PX;
		pdfY(:,:,b) = PY;
		pdfXY(:,:,:,b) = PXY;

		% Compute MIs looping over bins per lag
		for i = 1:r
			if size(W,1) == 1,
				logPXY = log2(squeeze(PXY(:,i,:))'./PX(:,i)./PY);
				logPXY(squeeze(PXY(:,i,:))'<=10^-8) = 0;
				MI(:,b) = MI(:,b) + sum(squeeze(PXY(:,i,:))'.*logPXY,2);
			else
				logPXY = log2(squeeze(PXY(:,i,:))./PX(:,i)./PY);
				logPXY(squeeze(PXY(:,i,:))<=10^-8) = 0;
				MI(:,b) = MI(:,b) + sum(squeeze(PXY(:,i,:)).*logPXY,2);
			end
		end

		% Compute R (independent of bins) per lag
		R(:,b) = squeeze(SXY(:,1,2))./(sqrt(SX).*sqrt(SY));

	end % End lag loop

end % EOF gkde_mi
