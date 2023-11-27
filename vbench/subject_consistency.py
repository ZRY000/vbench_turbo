import io
import os
import cv2
import json
import numpy as np
from PIL import Image
from tqdm import tqdm

import torch
import torch.nn as nn
import torch.nn.functional as F
import torchvision.transforms as transforms

from .utils import load_video, load_dimension_info, dino_transform
import logging
logging.basicConfig(level = logging.INFO,format = '%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

def subject_consistency(model, video_list, device):
    sim = 0.0
    cnt = 0
    video_results = []
    image_transform = dino_transform(224)
    for video_path in tqdm(video_list):
        video_sim = 0.0
        images = load_video(video_path)
        images = image_transform(images)
        for i in range(len(images)):
            with torch.no_grad():
                image = images[i].unsqueeze(0)
                image = image.to(device)
                image_features = model(image)
                image_features = F.normalize(image_features, dim=-1, p=2)
                if i == 0:
                    first_image_features = image_features
                else:
                    sim_pre = max(0.0, F.cosine_similarity(former_image_features, image_features).item())
                    sim_fir = max(0.0, F.cosine_similarity(first_image_features, image_features).item())
                    cur_sim = (sim_pre + sim_fir) / 2
                    video_sim += cur_sim
                    cnt += 1
            former_image_features = image_features
        sim += video_sim
        video_results.append({'video_path': video_path, 'video_results': video_sim})
    sim_per_video = sim / (len(video_list) - 1)
    sim_per_frame = sim / cnt
    return sim_per_frame, video_results


def compute_subject_consistency(json_dir, device, submodules_list):
    dino_model = torch.hub.load(**submodules_list).to(device)
    logger.info("Initialize DINO success")
    video_list, _ = load_dimension_info(json_dir, dimension='subject_consistency', lang='en')
    all_results, video_results = subject_consistency(dino_model, video_list, device)
    return all_results, video_results
