#!/usr/bin/env python3

import os
import argparse
import random


def main():
    # set possible transitions types to fade images
    transitions = ["wipe", "top", "bottom", "left", "right"]
    smoothness = 100
    duration = 1
    fps = 60

    # get path to wallpapers directory from command line
    parser = argparse.ArgumentParser()
    parser.add_argument("--path", help="path to wallpapers directory")
    args = parser.parse_args()

    # get list of files in wallpapers directory
    files = os.listdir(args.path)

    # get list of images
    images = [f for f in files if f.endswith((".png", ".jpg", ".jpeg"))]

    # pick a random image
    image = random.choice(images)

    # pick a random transition
    transition = random.choice(transitions)

    print(f"Setting wallpaper to {image} with transition {transition}")

    # set the wallpaper
    os.system(
        f'swww img "{args.path}/{image}" --transition-type "{transition}" --transition-step "{smoothness}" --transition-fps "{fps}" --transition-duration "{duration}"'
    )


if __name__ == "__main__":
    main()
