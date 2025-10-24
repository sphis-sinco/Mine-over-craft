import sys.io.File;
import haxe.Json;

class ChangelogGenerator {
	static var changelogJson:Changelog;
	static var resultChangelog:String;

	public static function main() {
		changelogJson = Json.parse(File.getContent('changelog.json'));

		var topics:Map<Dynamic, String> = new Map<Dynamic, String>();

		trace('Parsing topics');
		for (topic in changelogJson.topics) {
			trace('topic=' + topic.topic + ' | topic_id=' + topic.topic_id);
			topics.set(topic.topic_id, topic.topic);
		}

		trace('Parsing entries');
		resultChangelog = '# '+(changelogJson.product_name ?? 'Changelog')+'' + ((changelogJson.version != null) ? ' v${changelogJson.version}' : '') + '\n';

		for (entry in changelogJson.entries) {
			var finalEntry = '[${topics.get(entry.topic_id) ?? entry.topic_id}] ${entry.text}';

			resultChangelog += finalEntry + '\n';
		}

		Sys.println(resultChangelog);
	}
}

typedef Changelog = {
	var ?product_name:String;
	var ?version:String;

	var topics:Array<ChangelogTopics>;
	var entries:Array<ChangelogEntries>;
}

typedef ChangelogTopics = {
	topic:String,
	topic_id:Dynamic,
}

typedef ChangelogEntries = {
	topic_id:Dynamic,
	text:String,
}
