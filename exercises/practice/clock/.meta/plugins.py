def to_hour_minute_record(input):
    hour = input.get("hour", 0)
    minute = input.get("minute", 0)
    fields = []
    if hour != 0:
        fields.append(f"hour: {hour}")
    if minute != 0:
        fields.append(f"minute: {minute}")
    return "{ " + ", ".join(fields) + " }" if fields else "{}"
