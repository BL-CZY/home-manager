function getVolumeIcon(volumeLevel, isMuted) {
    if (isMuted) {
        return "audio-volume-muted";
    } else if (volumeLevel < 30) {
        return "audio-volume-low";
    } else if (volumeLevel < 70) {
        return "audio-volume-medium";
    } else {
        return "audio-volume-high";
    }
}

function getBrightnessIcon(brightnessLevel) {
    if (brightnessLevel < 30) {
        return "display-brightness-low";
    } else if (brightnessLevel < 70) {
        return "display-brightness-medium";
    } else {
        return "display-brightness-high";
    }
}