def to_hours_minutes_record(input):
    hours = input.get("hour", 0)
    minutes = input.get("minute", 0)
    fields = []
    if hours != 0:
        fields.append(f"hours: {hours}")
    if minutes != 0:
        fields.append(f"minutes: {minutes}")
    if fields:
        content = ", ".join(fields)
        return "{ " + content + " }"
    else:
        return "{}"
