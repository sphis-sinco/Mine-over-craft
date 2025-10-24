# Requirements

- Haxe (Latest should be function)

# Running (Without runner):

```bat
haxe -m ChangelogGenerator --interp
```

## Custom File Input Path

```bat
haxe -m ChangelogGenerator --interp -D file_input_path="your_path"
```

## Custom File Output Path Prefix

```bat
haxe -m ChangelogGenerator --interp -D file_output_path_prefix="output_path_prefix"
```

# Running (With runner):

```bat
haxe runner.hxml
```

## Custom File Input Path

```bat
haxe runner.hxml -D file_input_path="your_path"
```

## Custom File Output Path Prefix

```bat
haxe runner.hxml -D file_output_path_prefix="output_path_prefix"
```
