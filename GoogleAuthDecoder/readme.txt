docker run -it --rm golang /bin/bash
go install github.com/dim13/otpauth@latest
bin/otpauth -link otpauth-migration://offline?data=XXXXXXX
