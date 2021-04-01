extension DurationUtils on Duration {
  String getTimeDifferenceString() {
    final diffSecs = this.inSeconds.remainder(60).abs();
    final diffMinutes = this.inMinutes.remainder(60).abs();
    final diffHours = this.inHours.abs();
    String out = "";
    if (diffHours > 0) {
      out += "$diffHours hours ";
    }

    if (diffMinutes > 0) {
      out += "$diffMinutes minutes ";
    }

    if (diffSecs > 0) {
      out += "$diffSecs seconds ";
    }

    if (out.length > 1) {
      out = out.substring(0, out.length - 1);
    }

    return out;
  }
}
