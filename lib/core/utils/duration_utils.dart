extension DurationUtils on Duration {
  String getTimeDifferenceString() {
    final diff = this.inSeconds.abs();
    final diffSecs = (diff % 60).round();
    final diffMinutes = ((diff / 60) % 60).round();
    final diffHours = (diff / (60 * 60)).round();
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
