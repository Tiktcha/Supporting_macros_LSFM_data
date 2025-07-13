minVal = 38402;  // Set your desired min intensity
maxVal = 65535; // Set your desired max intensity

// Loop through all open images
for (i = 1; i <= nImages; i++) {
    selectImage(i);  // Select each image (ImageJ index starts at 1)
    setMinAndMax(minVal, maxVal);  // Apply brightness adjustment
    run("Apply LUT");  // Make changes permanent
}

