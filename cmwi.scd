s.boot;

(
var notes, on, off, prs;

MIDIClient.init;
MIDIIn.connectAll;

notes = Array.newClear(128);

on = MIDIFunc.noteOn({ |veloc, num, chan, src|
    notes[num] = Synth(\default, [\freq, num.midicps,
        \amp, veloc * 0.00315]);
});

off = MIDIFunc.noteOff({ |veloc, num, chan, src|
    notes[num].release;
});

prs = MIDIFunc.cc({ |func, ccNum, chan, src|
	if (ccNum == 2,
		{ ("" + func + ccNum + chan + src).postln;
			notes.do ({ arg item, index;
				item.set(\amp, func);
			});
		},
		{ });
});

q = { on.free; off.free; prs.free };
)

// when done:
q.value;