// Ask the user to select a folder
dir = getDirectory("Choose a folder containing H5 files");

// Ensure directory path uses correct slashes
dir = replace(dir, "\\", "/"); // Convert any backslashes to forward slashes

// Get list of all files in the selected folder
list = getFileList(dir);

// Filter out only .h5 files
h5List = newArray();
for (i = 0; i < list.length; i++) {
    if (endsWith(list[i], ".h5")) {
        h5List = Array.concat(h5List, list[i]);
    }
}

// Check if any .h5 files were found
if (h5List.length == 0) {
    exit("No .h5 files found in the selected folder.");
}

// Loop through each .h5 file and open it
for (i = 0; i < h5List.length; i++) {
    path = dir + h5List[i];  // Construct full file path
    dataset = "Data";        // Dataset name

    // Construct the HDF5 file URL format
    url = "hdf5://file:/" + path + "?" + dataset;

    // Open the image
    run("HDF5/N5/Zarr/OME-NGFF ... ", "url=" + url);

    // Wait to ensure the image loads
    wait(500);

    // Get the actual title of the opened image
    title = getTitle();
    print("Opened Image: " + title);

    // Extract filename without .h5 extension
    newName = replace(h5List[i], ".h5", "");

    // Rename the image to match the file name
    rename(newName);
}

