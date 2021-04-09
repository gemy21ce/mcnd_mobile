extension DurationUtils on Duration {
  String getTimeDifferenceString({
    bool seconds = true,
    bool minutes = true,
    bool hours = true,
  }) {
    final int diffSecs = inSeconds.remainder(60).abs();
    final int diffMinutes = inMinutes.remainder(60).abs();
    final int diffHours = inHours.abs();
    String out = '';
    if (hours && diffHours > 0) {
      out += '$diffHours hours ';
    }

    if (minutes && diffMinutes > 0) {
      out += '$diffMinutes minutes ';
    }

    if (seconds && diffSecs > 0) {
      out += '$diffSecs seconds ';
    }

    if (out.length > 1) {
      out = out.substring(0, out.length - 1);
    }

    return out;
  }
}
