ENTRY(_ksetup);

SECTIONS {
	. = 0x8A00;

	.setup : {
	       _ksetup = .;
	       *(.setup)
	}

	.text : {
	       *(.test)
	}

	.rodata : {
	       *(.rodata)
	}

	.data : {
	       *(.data)
	}

	.bss : {
	       *(.bss)
	}
}
