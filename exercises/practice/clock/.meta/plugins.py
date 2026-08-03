def to_hour_minute_record(input):
    hour = input.get("hour", 0)
    minute = input.get("minute", 0)
    return f'{{hour: {hour}, minute: {minute}}}'