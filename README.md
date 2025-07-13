# Supporting scripts for publication  
These macro scripts, developed for use with Fiji (ImageJ), enables batch processing of single-channel images acquired using the TruLive3D Imager Light-Sheet Fluorescence Microscopy (LSFM) system (Luxendo GmbH, Heidelberg, Germany).
`N1_Image_opener.ijm.ijm.ijm` automatically imports the datasets without much manual intervention;
`N2_Adjust_BR.ijm.ijm.ijm` adjusts the brightness of all opened images;
`N3_Split_stack.ijm.ijm.ijm` aplits the Z-stacks into individual images (.tif) and saves them in a single folder;
`N4_Viability_calculations_LSFM_CAM.ijm` was forked and modified from here : `sophie-mountcastle/Biofilm-Viability-Checker`
It analyzes Calcein AM-stained biofilms by quantifying the number of CAM-positive pixels, providing a measure of viable cell area. In addition, the script generates and saves overlay images that visually highlight the detected bacterial regions.
