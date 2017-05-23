import json

with open("/etc/ssowat/conf.json.persistent", "r") as jsonFile:
    data = json.load(jsonFile)
    if "skipped_urls" in data:
        data["skipped_urls"].append("/seafhttp")
    else:
        data["skipped_urls"] = ["/seafhttp"]
    data["skipped_urls"].append("/seafdav")

with open("/etc/ssowat/conf.json.persistent", "w") as jsonFile:
    jsonFile.write(json.dumps(data, indent=4, sort_keys=True))
