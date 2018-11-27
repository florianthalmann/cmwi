s.boot;

(
var synth, on, cc;

MIDIClient.init;
MIDIIn.connectAll;

synth = Synth(\default, [\freq, 0, \amp, 0]);

on = MIDIFunc.noteOn({ |veloc, num, chan, src|
    synth.set(\freq, num.midicps);
});

cc = MIDIFunc.cc({ |func, ccNum, chan, src|
	if (ccNum == 2,
		{ synth.set(\amp, func); },
		{ });
});

q = { on.free; off.free; prs.free };
)

// when done:
q.value;