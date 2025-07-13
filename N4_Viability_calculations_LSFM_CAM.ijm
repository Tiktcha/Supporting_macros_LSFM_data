// This macro processes single-channel images stained with Calcein AM (CAM).
// It calculates the number of pixels representing live bacteria and saves overlay images if selected.

Dialog.create("Biofilm CAM Analysis");
Dialog.addMessage("This macro processes fluorescence images of biofilm stained with CAM to calculate the amount of metabolic active bacteria in each image.\n\nFirst put your image(s) to be processed in a separate input folder.");
Dialog.addString("Add image file type suffix: ", ".tif", 5);
Dialog.addCheckbox("Save overlay images", true);
Dialog.addMessage("Tick this to save overlay images of the detected areas to your output folder. The detected metabolic active bacteria are outlined in green.");
Dialog.addMessage("Click OK to choose your input and output directories.\nAfter processing, you will be able to save the log file containing the amount of metabolic active bacteria in each image.");
Dialog.show();

suffix = Dialog.getString();
overlay = Dialog.getCheckbox();

gammavalue = 1; // Default gamma value

input = getDirectory("Input directory");
output = getDirectory("Output directory");

processFolder(input);

function processFolder(input) {
    list = getFileList(input);
    for (i = 0; i < list.length; i++) {
        if (File.isDirectory(input + list[i])) {
            processFolder("" + input + list[i]);
        }
        if (endsWith(list[i], suffix)) {
            processFile(input, output, list[i]);
        }
    }
}

function processFile(input, output, file) {
    open(input + File.separator + file);
    title = getTitle();

    // Image segmentation for CAM (green channel)
    run("Auto Threshold", "method=Otsu white");
    run("Analyze Particles...", "size=10-Infinity pixel show=Nothing clear"); // Adjust the size filter as needed

    // Measure the number of white pixels (detected CAM area)
    run("Clear Results");
    setOption("ShowRowNumbers", false);
    getRawStatistics(n, mean, min, max, std, hist);
    CAMpix = hist[255]; // Get count of white pixels (255 intensity)

    // Save results to the log
   
    print(title + "\t" + CAMpix);

    // Overlay creation if enabled
    if (overlay) {
        selectWindow(title);
        run("Outline");             // Create an outline of the detected live areas
        run("Create Selection");     // Turn the outline into a selection
        setForegroundColor(0, 255, 0);  // Set color to green for live cells
        run("Restore Selection");    // Apply the selection
        run("Fill", "slice");        // Fill the selection with green color
        run("Select None");          // Deselect the selection

        // Save the image with overlays
        saveAs("Tiff", output + "overlay_" + file);
    }

    close(); // Close the processed image
}

// Save the log results
selectWindow("Log");
saveAs("Text", output + "analysis_log.txt");
