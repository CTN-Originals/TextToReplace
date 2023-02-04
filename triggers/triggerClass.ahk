class TriggerData {
	__New(trigger) {
		this.trigger := trigger
		this.output := ""
		this.state := true

		; Input options
		this.confirmation := true
		this.confirmationTime := 5000 ; 5 seconds
		this.caseSensitive := false
		this.keepInput := false

		; Output options
		this.outputType := "text"
		this.outputDelay := 0
		this.outputSpeed := 0
		this.fromClipboard := false

		this.Validate()
	}

	Validate() {

	}
}

Global TriggerDataCollection := {}