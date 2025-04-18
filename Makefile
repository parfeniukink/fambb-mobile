.PHONY: run
run:
	flutter run --hot --debug -d 887D8C83-61C9-4C2B-861B-DFB3BE3B0630

.PHONY: build
build:
	flutter build ios --release

.PHONY: deploy
deploy:
	flutter install

# NOTE: ***********************************************
# Update the .freezed and .g files for all the entities
# *****************************************************
.PHONY: update
update:
	dart run build_runner build -d
