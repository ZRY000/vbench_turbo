#!/bin/bash

# Define the dimension list
dimensions=("subject_consistency" "background_consistency" "aesthetic_quality" "imaging_quality" "object_class" "multiple_objects" "color" "spatial_relationship" "scene" "temporal_style" "overall_consistency" "human_action" "motion_smoothness" "dynamic_degree" "appearance_style")

# Corresponding folder names
folders=("subject_consistency" "scene" "overall_consistency" "overall_consistency" "object_class" "multiple_objects" "color" "spatial_relationship" "scene" "temporal_style" "overall_consistency" "human_action" "subject_consistency" "subject_consistency" "appearance_style")

# Base path for videos
# exp_dir='/home/juntao/Projects/zry/value-gradient/project_dir/vbench-2024-11-09-15-10-58'
exp_dir='/home/juntao/Projects/zry/VADER/VADER-VideoCrafter/project_dir/vbench-vc-2024-12-17-15-00-35'
base_path="${exp_dir}/videos" # TODO: change to local path

# evaluate dimensions except temporal_flickering

# Loop over each dimension
for i in "${!dimensions[@]}"; do
    # Get the dimension and corresponding folder
    dimension=${dimensions[i]}
    folder=${folders[i]}

    # Construct the video path
    videos_path="${base_path}/${folder}"
    echo "$dimension $videos_path"

    # Run the evaluation script
    python evaluate.py --videos_path $videos_path --dimension $dimension --output_path $exp_dir
done


# evaluate temporal_flickering
python static_filter.py --videos_path "${base_path}/temporal_flickering"
python evaluate.py --videos_path "${base_path}/temporal_flickering" --dimension "temporal_flickering" --output_path $exp_dir
python scripts/overall_score.py --results_path $exp_dir

