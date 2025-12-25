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