function percentage_to_icon(percentage, onBattery) {
    console.log(percentage + "%")
    console.log("On Battery: " + onBattery)

    if (!onBattery) {
        return "󰂄"
    }

    if (percentage >= 0.95) {
        return " "
    }

    if (percentage >= 0.65) {
        return " "
    }

    if (percentage >= 0.40) {
        return " "
    }

    if (percentage >= 0.10) {
        return " "
    }

    return " "
}

function percentage(percentage) {
    return `${Math.trunc(percentage * 100)}%`
}