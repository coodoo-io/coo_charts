clean:
	flutter clean
	flutter pub get
	make build-runner
	make format
format:
	dart format . --line-length 120
format-check:
	dart format . --line-length 120 --set-exit-if-changed
lint:
	flutter analyze --no-pub

# Build runner
build-runner:
	dart run build_runner build --delete-conflicting-outputs
build-runner-watch:
	dart run build_runner watch --delete-conflicting-outputs