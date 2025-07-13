dir = getDirectory("Choose a Directory");
for (i = 1; i <= nSlices; i++) {
    setSlice(i);  // Select the i-th slice
    run("Duplicate...", "title=Slice_" + i);  // Duplicate the current slice
    saveAs("Tiff", dir + "slice_" + i + ".tif");  // Save the duplicate as a separate TIFF file
    close();  // Close the duplicated image to avoid clutter
}
