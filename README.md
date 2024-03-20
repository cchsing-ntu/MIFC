# Welcome to the BML MIFC project :-D

2022.03.02 Created by Jess CC Hsing
2023.11.08 Edited by Jess CC Hsing
2024.03.20 Added descriptions for the new directories.

This project is created by Jess Chih-Chia Hsing (邢芝嘉) - Twitter: @JessHsing - r08454015*(at)*ntu.edu.tw

## About the Project
MIFC stands for **M**utual **I**nformation **F**unctional **C**onnectivity. It was originally a project for Chih-Chia Hsing's [Master's Thesis](https://www.airitilibrary.com/Publication/alDetailedMesh1?DocID=U0001-2901202215233900). The aim of this project is to evaluate functional connectivity calculated by mutual information and Pearson's Correlation. To perform such investigation, we specifically looked at the functional connectivity of the four midbrain nuclei (namely the VTA, DRN, MRN and LC) to the rest of the brain. In the master's thesis, we only focused data of the 135 young subjects that was collected by previous BML members. Right now (as of March 2022), we will start working on comparing the difference between young and old subjects.

### Built with
- **[MATLAB](https://www.mathworks.com/products/matlab.html) 2018b** throughout the project.
- **[RESTplus](http://www.restfmri.net/forum/restplus) v1.24** for detrending.
- **[SPM12](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/)** for most of the preprocessing and DARTEL.
- **[AAL3](https://www.gin.cnrs.fr/en/tools/aal/)** for brain region labeling.

## Directory Structure
There are two versions for the project. If you are reading this README.md without manually opening it then you are probably looking at the GitLab version. There is another version in the BMLabUnit03 Server where all the data lives.

### 1. Data Structure
Basically, the Git version only contains the code that I have written and the subject list for the study.
- **00_resources:** Contains resouces that are needed for this project.
  - **midbrain:** The midbrain ROI masks in MNI space that this study utilizes.
- **01_tools:** Some tool codes that I use across the analysis.
- **02_preprocessing:** Batch files and scripts that helps with the preprocessing.
- **03_extract_signals:** Scripts that I use to convert the NIfTI files to MI files.

### 2. Commit Rules:
The commits message I use follow the rules from [this page](https://hackmd.io/@howhow/git_commit). In this project,wwwe only use the header part. My commit messages comprises of two parts: the first part specifys the *type* of the commit, while the second part specifies the *descriptions* to the commit.

The types are:
- docs: Documentation only changes
- feat: A new feature
- fix: A bug fix
- perf: A code change that improves performance
- refractor: A code change that neither fixes a bug nor adds a feature
- style: Changes that do not affect the meaning of the code (*white-space, formatting, missing semi-colons, etc*) 

The descriptions should be succinct and follow the rules:
- ENGLISH ONLY
- Less than 50 characters
- don't capitalize the first letter
- no dot(.) at the end
- use the imperative, present tense: "change" not "changed" nor "changes"

