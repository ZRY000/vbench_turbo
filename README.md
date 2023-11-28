# :bar_chart: VBench 

<!-- [![arXiv](https://img.shields.io/badge/arXiv-2311.99999-b31b1b.svg)](https://arxiv.org/abs/2311.99999) -->
[![Paper](https://img.shields.io/badge/cs.CV-Paper-b31b1b?logo=arxiv&logoColor=red)](https://vchitect.github.io/VBench-project/assets/vbench/VBench_paper.pdf)
[![Project Page](https://img.shields.io/badge/VBench-Website-green?logo=googlechrome&logoColor=green)](https://vchitect.github.io/VBench-project/)
[![HuggingFace](https://img.shields.io/badge/%F0%9F%A4%97%20Hugging%20Face-Leaderboard-blue)](https://huggingface.co/spaces/VBench/T2V-Leaderboard)
[![Paper](https://img.shields.io/badge/YouTube-Video-c4302b?logo=youtube&logoColor=red)](https://www.youtube.com/watch?v=7IhCC8Qqn8Y)


This repository contains the implementation of the following paper:
> **VBench: Comprehensive Benchmark Suite for Video Generative Models**<br>
> [Ziqi Huang](https://ziqihuangg.github.io/)<sup>∗</sup>, [Yinan He](https://github.com/yinanhe)<sup>∗</sup>, [Jiashuo Yu](https://scholar.google.com/citations?user=iH0Aq0YAAAAJ&hl=zh-CN)<sup>∗</sup>, [Fan Zhang](https://github.com/zhangfan-p)<sup>∗</sup>, [Chenyang Si](https://chenyangsi.top/), [Yuming Jiang](https://yumingj.github.io/), [Yuanhan Zhang](https://zhangyuanhan-ai.github.io/),  [Tianxing Wu](https://tianxingwu.github.io/), Qingyang Jin, [Nattapol Chanpaisit](https://nattapolchan.github.io/me), [Yaohui Wang](https://wyhsirius.github.io/), [Xinyuan Chen](https://scholar.google.com/citations?user=3fWSC8YAAAAJ), [Limin Wang](https://wanglimin.github.io), [Dahua Lin](http://dahua.site/)<sup>+</sup>, [Yu Qiao](http://mmlab.siat.ac.cn/yuqiao/index.html)<sup>+</sup>, [Ziwei Liu](https://liuziwei7.github.io/)<sup>+</sup><br>


## :mega: Overview
![overall_structure](./asset/fig_teaser_new.jpg)
We propose **VBench**, a comprehensive benchmark suite for video generative models. We design a comprehensive and hierarchical <b>Evaluation Dimension Suite</b> to decompose "video generation quality" into multiple well-defined dimensions to facilitate fine-grained and objective evaluation. For each dimension and each content category, we carefully design a <b>Prompt Suite</b> as test cases, and sample <b>Generated Videos</b> from a set of video generation models. For each evaluation dimension, we specifically design an <b>Evaluation Method Suite</b>, which uses carefully crafted method or designated pipeline for automatic objective evaluation. We also conduct <b>Human Preference Annotation</b> for the generated videos for each dimension, and show that VBench evaluation results are <b>well aligned with human perceptions</b>. VBench can provide valuable insights from multiple perspectives.

## :fire: Updates
- [11/2023] Evaluation code for released for this list of dimensions: `['subject_consistency', 'background_consistency', 'aesthetic_quality', 'object_class', 'multiple_objects', 'human_action', 'color', 'spatial_relationship', 'scene', 'temporal_style', 'appearance_style', 'overall_consistency']`
- [11/2023] Prompt Suites released. (See prompt lists [here](https://github.com/Vchitect/VBench/tree/master/prompts))

## :hammer: Installation

1. Clone Repo

   ```bash
   git clone https://github.com/Vchitect/VBench
   cd VBench
   ```

2. Create Conda Environment and Install Dependencies
    ```
    conda env create -f vbench_env.yml
    conda activate vbench
    ```

## :gem: Pre-Trained Models
[Optional] Please download the pre-trained weights according to the guidance in the `model_path.txt` file for each model in the `pretrain` folder.

## :bookmark_tabs: Prompt Suite

We provide prompt lists are at `prompts/`, see [instructions](https://github.com/Vchitect/VBench/tree/master/prompts) for details.

## :surfer: Evaluation Method Suite

To perform evaluation, run this:
```
import torch
from vbench import VBench

device = torch.device("cuda")
output_path = './evaluation_results/'
full_json_dir = './VBench_full_info.json'
videos_path = "{your_video_dir}" # change to folder that contains the sampled videos
my_VBench = VBench(device, full_json_dir, output_path)
my_VBench.evaluate(
    videos_path = videos_path,
    name = 'test',
    dimension_list = {list_of_dimension}, # change to the list of dimension, e.g. ['human_action','scene']
    local=False, # Whether to use local checkpoints. If true, vbench will load model weights locally.
)
```

- The complete list of dimensions:
    ```
    ['subject_consistency', 'background_consistency', 'temporal_flickering', 'motion_smoothness', 'dynamic_degree', 'aesthetic_quality', 'imaging_quality', 'object_class', 'multiple_objects', 'human_action', 'color', 'spatial_relationship', 'scene', 'temporal_style', 'appearance_style', 'overall_consistency']
    ```
- Dimensions currently open-sourced (the remaining will be added soon):
    ```
    ['subject_consistency', 'background_consistency', 'aesthetic_quality', 'object_class', 'multiple_objects', 'human_action', 'color', 'spatial_relationship', 'scene', 'temporal_style', 'appearance_style', 'overall_consistency']
    ```


## :black_nib: Citation

   If you find our repo useful for your research, please consider citing our paper:

   ```bibtex
    @article{huang2023bench,
        title={{VBench}: Comprehensive Benchmark Suite for Video Generative Models},
        author={Huang, Ziqi and He, Yinan and Yu, Jiashuo and Zhang, Fan and Si, Chenyang and Jiang, Yuming and Zhang, Yuanhan and Wu, Tianxing and Jin, Qingyang and Chanpaisit, Nattapol and Wang, Yaohui and Chen, Xinyuan and Wang, Limin and Lin, Dahua and Qiao, Yu and Liu, Ziwei}
        journal={arXiv preprint}
        year={2023}
    }
   ```


## :hearts: Acknowledgement

This codebase is maintained by [Ziqi Huang](https://ziqihuangg.github.io/), [Yinan He](https://github.com/yinanhe), [Jiashuo Yu](https://scholar.google.com/citations?user=iH0Aq0YAAAAJ&hl=zh-CN), [Fan Zhang](https://github.com/zhangfan-p), and [Nattapol Chanpaisit](https://nattapolchan.github.io/me).

This project wouldn't be possible without the following open-sourced repositories:
[AMT](https://github.com/MCG-NKU/AMT/), [UMT](https://github.com/OpenGVLab/unmasked_teacher), [RAM](https://github.com/xinyu1205/recognize-anything), [CLIP](https://github.com/openai/CLIP), [RAFT](https://github.com/princeton-vl/RAFT), [GRiT](https://github.com/JialianW/GRiT), [IQA-PyTorch](https://github.com/chaofengc/IQA-PyTorch/), [ViCLIP](https://github.com/OpenGVLab/InternVideo/tree/main/Data/InternVid), and [LAION Aesthetic Predictor](https://github.com/LAION-AI/aesthetic-predictor).
