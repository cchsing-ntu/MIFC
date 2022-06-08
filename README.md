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
There are two versions for the project. If you are reading this README.md without manually opening it then you are probably looking at the GitLab version. There is another version in the BMLabUnit02 Server where all the data lives.

### 1. Git Version Structure
Basically, the Git version only contains the code that I have written and the subject list for the study.
- **admin:** Administrative stuff. You can find the subject list here. I have removed all the personal information in the git version.
- **code:** All the organized codes that I've used for the project. Including the preprocessing and functional connectivity calculations.

### 2. Server Version Structure
The directory in the server is roughly saved in the [BIDS](https://bids.neuroimaging.io/) format.

- **admin:** Administrative stuff. You can find the subject list here. I also saved the "raw" subject list from previous studies separately.
- **archive:** Old files that are no longer used. I might consider deleting them to save server space.
- **code:** All the main codes for the analysis. Notice that some of the codes for the 2nd-level analysis were in the `derivatives/2ndlvl` directory.
- **code-raw:** These are the codes that were not organized yet. So yes, all the raw things that I used to write for my analysis.
- **data:** This is where all the raw DICOM files are saved.
  - **DCM_OA:** Subject data in MIFC subject IDs that belongs to the **o**ld **a**dult group.
  - **DCM_YA:** Subject data in MIFC subject IDs that belongs to the **y**oung **a**dult group.
  - **ORI_OA:** Subject data in their **ori**ginal subject IDs that belongs to the **o**ld **a**dult group.
  - **ORI_YA:** Subject data in their **ori**ginal subject IDs that belongs to the **y**oung **a**dult group.
- **derivatives:** Imaging files and data that have been processed.
  - **2ndlvl:** All the 2nd-level files and results.
  - **mat:** Data that were saved in the format of mat files.
  - **nifti:** All the subject-level NIfTI files. Each directory is data for one subject.
  - **ROI_analysis:** Data for an interim ROI-analysis. The ROIs were results from a second-level study.
- **resources:** Resources for the analysis.
  - **AAL3:** The AAL3 toolkit.
  - **ROI:** ROIs that are in the MNI space.
  - **ySST:** **S**tudy **S**pecific **T**emplate that we created. This version only included the young subjects.
- **results:** Past results that I have made. They are mostly images.

## Subject Pool
The list below is where I found these projects in the BML server.

1. **ADMS:**  `BMLabUnit01-> Bank5/ADM/Data/source/ses-sss/sub/dicom`
2. **DEFG:**  `BMLabUnit01-> Bank3/DEF/MIR_DEFG_Mdl3`
3. **DM-ERP:** `BMLabUnit01-> Bank3/ERP/DM_ERP/subjects/RAW`
4. **PROS-PILOT:** `BMLabUnit01-> Bank5/Pilot/Raw`

## Contact
Jess Chih-Chia Hsing (邢芝嘉) - Twitter: @JessHsing - r08454015*(at)*ntu.edu.tw
