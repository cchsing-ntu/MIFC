# Welcome to the BML MIFC project :-D

Last updated: 2022.03.02 by Jess CC Hsing



## About the Project
MIFC stands for **M**utual **I**nformation **F**unctional **C**onnectivity. It was originally a project for Chih-Chia Hsing's [Master's Thesis](https://www.airitilibrary.com/Publication/alDetailedMesh1?DocID=U0001-2901202215233900). The aim of this project is to evaluate functional connectivity calculated by mutual information and Pearson's Correlation. To perform such investigation, we specifically looked at the functional connectivity of the four midbrain nuclei (namely the VTA, DRN, MRN and LC) to the rest of the brain. In the master's thesis, we only focused data of the 135 young subjects that was collected by previous BML members. Right now (as of March 2022), we will start working on comparing the difference between young and old subjects.

### Built with
- **[MATLAB](https://www.mathworks.com/products/matlab.html) 2018b** throughout the project.
- **[RESTplus](http://www.restfmri.net/forum/restplus) v1.24** for detrending.
- **[SPM12](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/)** for most of the preprocessing and DARTEL.
- **[AAL3](https://www.gin.cnrs.fr/en/tools/aal/)** for brain region labeling.

## Directory Structure
There are two versions for the project. If you are reading this README.md without manually opening it then you are probably looking at the GitLab version. There is another version in the BMLabUnit03 Server where all the data lives.

### 1. Git Version Structure
Basically, the Git version only contains the code that I have written and the subject list for the study.
- **admin:** Administrative stuff. You can find the subject list here. I have removed all the personal information in the git version.
- **code:** All the organized codes that I've used for the project. Including the preprocessing and functional connectivity calculations.
Jess Chih-Chia Hsing (邢芝嘉) - Twitter: @JessHsing - r08454015*(at)*ntu.edu.tw
