#!/bin/bash

# Define the dimension list
dimensions=("subject_consistency" "background_consistency" "aesthetic_quality" "imaging_quality" "motion_smoothness" "dynamic_degree")

# Loop over each dimension
for i in "${!dimensions[@]}"; do
    # Get the dimension 
    dimension=${dimensions[i]}

    # Construct the video path
    videos_path="/path/to/folder_or_video/"
    echo "$dimension $videos_path"

    # Run the evaluation script
    python evaluate.py --videos_path $videos_path --dimension $dimension --mode=custom_input
done

