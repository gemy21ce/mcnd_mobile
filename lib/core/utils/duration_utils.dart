extension DurationUtils on Duration {
  String getTimeDifferenceString({
    bool seconds = true,
    bool minutes = true,
    bool hours = true,
  }) {
    final diffSecs = this.inSeconds.remainder(60).abs();
    final diffMinutes = this.inMinutes.remainder(60).abs();
    final diffHours = this.inHours.abs();
    String out = "";
    if (hours && diffHours > 0) {
      out += "$diffHours hours ";
    }

    if (minutes && diffMinutes > 0) {
      out += "$diffMinutes minutes ";
    }

    if (seconds && diffSecs > 0) {
      out += "$diffSecs seconds ";
    }

    if (out.length > 1) {
      out = out.substring(0, out.length - 1);
    }

    return out;
  }
}
