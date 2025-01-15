#!/bin/bash

# Define the dimension list
dimensions=("subject_consistency" "background_consistency" "aesthetic_quality" "imaging_quality" "motion_smoothness" "dynamic_degree")

exp_dir='/home/juntao/Projects/zry/VADER/VADER-VideoCrafter/project_dir/eval-vc-2024-12-30-01-22-04'
base_path="${exp_dir}/videos"
prompt_path="${exp_dir}/prompt_file.json"

# Loop over each dimension
for i in "${!dimensions[@]}"; do
    # Get the dimension 
    dimension=${dimensions[i]}

    # Construct the video path
    videos_path=$base_path
    echo "$dimension $videos_path"

    # Run the evaluation script
    python evaluate.py --videos_path $videos_path --dimension $dimension --mode=custom_input --output_path $exp_dir --prompt_file $prompt_path
done

python scripts/overall_score_custom.py --results_path $exp_dir
