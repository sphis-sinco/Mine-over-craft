import sys.FileSystem;
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
		resultChangelog = '# '
			+ (changelogJson.product_name ?? 'Changelog')
			+ ''
			+ ((changelogJson.version != null) ? ' v${changelogJson.version}' : '')
			+ '\n';

		for (entry in changelogJson.entries) {
			var finalEntry = '[${topics.get(entry.topic_id) ?? entry.topic_id}] ${entry.text}';

			resultChangelog += finalEntry + '\n';
		}

		var filename = '';
		filename = ((changelogJson.product_name != null) ? changelogJson.product_name : 'changelog');
		filename += ((changelogJson.product_name != null && changelogJson.version != null) ? '-' + changelogJson.version : '');
		filename += '-' + Date.now().getFullYear();
		filename += '-' + Date.now().getMonth();
		filename += '-' + Date.now().getDate();

		filename = checkForDupeFileName(filename, 0);

		filename += '.md';
		trace('Generated changelog file: ' + filename);
		File.saveContent(filename, resultChangelog);
	}

	static function checkForDupeFileName(filename:String, ?starting_index:Int = 0):String {
		var finalFilename = filename;
		var index = starting_index;

		if (FileSystem.exists(finalFilename + '.md')) {
			index += 1;

			if (FileSystem.exists(finalFilename + '-' + Std.string(index) + '.md'))
				return checkForDupeFileName(finalFilename, index);
		}

		if (index > 0) {
            trace(finalFilename + ' exists ' + Std.string(index) + ' time(s)!');
			return finalFilename + '-' + Std.string(index);
		} else
			return finalFilename;
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
