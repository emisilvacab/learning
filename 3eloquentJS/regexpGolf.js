/*
1.car and cat

2.pop and prop

3.ferret, ferry, and ferrari

4.Any word ending in ious

5.A whitespace character followed by a period, comma, colon, or semicolon

6.A word longer than six letters

7.A word without the letter e (or E)
*/

let re1 = /ca(r|t)/;
let re2 = /pr?op/;
let re3 = /ferr(et|y|ari)/;
let re4 = /[a-z]*ious($|\s)/i;
let re5 = /\s(\,|\.|\:|\;)/
let re6 = /[a-z]{7,}/i;
let re7 = /(^|\s)[^e]+($|\s)/i;

// Fill in the regular expressions

verify(re1,
       ["my car", "bad cats"],
       ["camper", "high art"]);

verify(re2,
       ["pop culture", "mad props"],
       ["plop", "prrrop"]);

verify(re3,
       ["ferret", "ferry", "ferrari"],
       ["ferrum", "transfer A"]);

verify(re4,
       ["how delicious", "spacious room"],
       ["ruinous", "consciousness"]);

verify(re5,
       ["bad punctuation ."],
       ["escape the period"]);

verify(re6,
       ["Siebentausenddreihundertzweiundzwanzig"],
       ["no", "three small words"]);

verify(re7,
       ["red platypus", "wobbling nest"],
       ["earth bed", "learning ape", "BEET"]);


function verify(regexp, yes, no) {
  // Ignore unfinished exercises
  if (regexp.source == "...") return;
  for (let str of yes) if (!regexp.test(str)) {
    console.log(`Failure to match '${str}'`);
  }
  for (let str of no) if (regexp.test(str)) {
    console.log(`Unexpected match for '${str}'`);
  }
}
