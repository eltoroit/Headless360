// ─── TODOs ─────────────────────────────────────────────────────────────────
List<TODO__c> todos = new List<TODO__c>();
Date d = Date.today();

Map<String, Id> conMap = new Map<String, Id>();
for (Contact c : [SELECT Id, FirstName, LastName FROM Contact WHERE Email LIKE '%example.com']) {
    conMap.put(c.FirstName + ' ' + c.LastName, c.Id);
}

Id mayId       = conMap.get('May Q\'Learn');
Id joeId       = conMap.get('Joe King');
Id willieId    = conMap.get('Willie Makit');
Id colinId     = conMap.get('Colin Sik');
Id manuelId    = conMap.get('Manuel Labor');
Id normaId     = conMap.get('Norma Leigh Absent');
Id earlId      = conMap.get('Earl E. Bird');
Id warrenId    = conMap.get('Warren Peace');
Id monaId      = conMap.get('Mona Lott');
Id hugoId      = conMap.get('Hugo First');
Id percyId     = conMap.get('Percy Vere');
Id alId        = conMap.get('Al Zeimers');
Id wynnId      = conMap.get('Wynn Dosaplikayshun');
Id deeId       = conMap.get('Dee Mandingboss');
Id constanceId = conMap.get('Constance Noring');

// May Q'Learn — "Make you learn"
todos.add(new TODO__c(Title__c='Read the manual before calling support — again',         Contact__c=mayId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(3)));
todos.add(new TODO__c(Title__c='Sign up for that Excel course (for real this time)',      Contact__c=mayId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Return library books before the fine exceeds rent',       Contact__c=mayId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Watch one TED talk and report back as if you invented it',Contact__c=mayId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(14)));
todos.add(new TODO__c(Title__c='Stop highlighting every sentence in the textbook',        Contact__c=mayId, Status__c='In Progress', Priority__c='Medium', DueDate__c=d.addDays(5)));
todos.add(new TODO__c(Title__c='Write summary notes BEFORE the exam, not during',         Contact__c=mayId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Bookmark fewer than 200 browser tabs this week',          Contact__c=mayId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Actually finish the online course (not just enrol)',      Contact__c=mayId, Status__c='In Progress', Priority__c='Medium', DueDate__c=d.addDays(30)));
todos.add(new TODO__c(Title__c='Ask a question in the meeting that is not off-topic',     Contact__c=mayId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(4)));
todos.add(new TODO__c(Title__c='Make flashcards. Use flashcards. Revolutionary.',         Contact__c=mayId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(6)));

// Joe King — "Joking"
todos.add(new TODO__c(Title__c='Prepare new material for Monday standup — last week bombed',Contact__c=joeId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Stop telling the printer joke in meetings',                Contact__c=joeId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Find someone who laughs at dad jokes (wife has banned them)',Contact__c=joeId,Status__c='In Progress', Priority__c='Medium', DueDate__c=d.addDays(30)));
todos.add(new TODO__c(Title__c='Write down one joke that is actually funny',               Contact__c=joeId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Stop laughing at own jokes before finishing them',         Contact__c=joeId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(5)));
todos.add(new TODO__c(Title__c='Test new material on the dog first (dog is honest)',       Contact__c=joeId, Status__c='In Progress', Priority__c='Low',    DueDate__c=d.addDays(3)));
todos.add(new TODO__c(Title__c='Retire the it is not a bug it is a feature line',         Contact__c=joeId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Learn one knock-knock joke that does not need explaining', Contact__c=joeId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(14)));
todos.add(new TODO__c(Title__c='Smile at own reflection — practice laughing WITH people', Contact__c=joeId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Accept that timing is everything. Research timing.',       Contact__c=joeId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(10)));

// Willie Makit — "Will he make it?"
todos.add(new TODO__c(Title__c='Set 4 alarms. This time actually get up.',                 Contact__c=willieId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Pre-pack gym bag Sunday night (it has been 3 months)',     Contact__c=willieId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(5)));
todos.add(new TODO__c(Title__c='Stop starting Netflix at 11pm on work nights',             Contact__c=willieId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Arrive to at least one meeting before it ends',            Contact__c=willieId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Renew car insurance (expires next week, again)',            Contact__c=willieId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(6)));
todos.add(new TODO__c(Title__c='Submit the expense report from 6 weeks ago',               Contact__c=willieId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Buy birthday card. Before the birthday.',                  Contact__c=willieId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(3)));
todos.add(new TODO__c(Title__c='Stop saying I will do it tonight about everything',        Contact__c=willieId, Status__c='In Progress', Priority__c='Low',    DueDate__c=d.addDays(365)));
todos.add(new TODO__c(Title__c='Call mum back. She has called 7 times this week.',         Contact__c=willieId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Finish at least one thing before starting a new thing',    Contact__c=willieId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(7)));

// Colin Sik — "Call-in sick"
todos.add(new TODO__c(Title__c='Stock up on cold and flu medicine (professionally)',       Contact__c=colinId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Memorise 3 convincing symptoms for Monday',               Contact__c=colinId, Status__c='In Progress', Priority__c='High',   DueDate__c=d.addDays(3)));
todos.add(new TODO__c(Title__c='Book doctor so voicemail sounds authentic',                Contact__c=colinId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(5)));
todos.add(new TODO__c(Title__c='Update sick day playlist — current one is suspiciously upbeat',Contact__c=colinId,Status__c='Not Started',Priority__c='Low', DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Learn to cough convincingly on Zoom',                     Contact__c=colinId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(4)));
todos.add(new TODO__c(Title__c='Stop checking Slack while bedridden',                     Contact__c=colinId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Buy soup. Soup makes it real.',                            Contact__c=colinId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Do not post on social media during sick days',             Contact__c=colinId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Track consecutive sick Mondays — for personal records',   Contact__c=colinId, Status__c='In Progress', Priority__c='Low',    DueDate__c=d.addDays(30)));
todos.add(new TODO__c(Title__c='Actually be sick one time. Just to keep things honest.',  Contact__c=colinId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(90)));

// Manuel Labor — "Manual Labor"
todos.add(new TODO__c(Title__c='Fix the squeaky gate (it has been 8 months)',              Contact__c=manuelId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Assemble IKEA KALLAX (box is currently a table)',          Contact__c=manuelId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(60)));
todos.add(new TODO__c(Title__c='Call plumber OR watch 12 YouTube videos and regret it',    Contact__c=manuelId, Status__c='In Progress', Priority__c='High',   DueDate__c=d.addDays(3)));
todos.add(new TODO__c(Title__c='Mow the lawn before neighbours form a search party',       Contact__c=manuelId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(4)));
todos.add(new TODO__c(Title__c='Return the drill to Dave. It has been two years.',         Contact__c=manuelId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(14)));
todos.add(new TODO__c(Title__c='Unclog the gutters before it rains again',                 Contact__c=manuelId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(5)));
todos.add(new TODO__c(Title__c='Buy lightbulb for hallway (dark since February)',          Contact__c=manuelId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Stop starting home improvement projects on Sunday evening',Contact__c=manuelId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Paint the shed. Just the shed. Nothing else.',             Contact__c=manuelId, Status__c='In Progress', Priority__c='Low',    DueDate__c=d.addDays(30)));
todos.add(new TODO__c(Title__c='Find the instruction manual for the thermostat',           Contact__c=manuelId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(7)));

// Norma Leigh Absent — "Normally absent"
todos.add(new TODO__c(Title__c='Find out what the team actually does on Tuesdays',         Contact__c=normaId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Reply to 3-week-old email from boss',                      Contact__c=normaId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Add calendar block called Working so people stop asking',  Contact__c=normaId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Show up to the meeting you scheduled',                     Contact__c=normaId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Learn colleagues names (all of them, this time)',          Contact__c=normaId, Status__c='In Progress', Priority__c='Low',    DueDate__c=d.addDays(30)));
todos.add(new TODO__c(Title__c='Turn on Slack notifications. Once. Just once.',            Contact__c=normaId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Submit timesheet before payroll chases you',               Contact__c=normaId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(3)));
todos.add(new TODO__c(Title__c='Attend one all-hands without pretending the call dropped', Contact__c=normaId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(14)));
todos.add(new TODO__c(Title__c='Find badge. It has been missing since the last in-person day.',Contact__c=normaId,Status__c='Not Started',Priority__c='Low',  DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Actually read the all-company email instead of archiving it',Contact__c=normaId,Status__c='Not Started',Priority__c='Low',   DueDate__c=d.addDays(5)));

// Earl E. Bird — "Early bird"
todos.add(new TODO__c(Title__c='Buy coffee beans so 5am is not a punishment',              Contact__c=earlId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Prep tomorrow lunch tonight (optimistic, but possible)',   Contact__c=earlId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Book standing desk — back has filed a formal complaint',   Contact__c=earlId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(3)));
todos.add(new TODO__c(Title__c='Stop being smug about 5am when nobody else is awake',     Contact__c=earlId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Renew car insurance (it expired last week)',               Contact__c=earlId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Schedule dentist appointment (overdue by 14 months)',      Contact__c=earlId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Read the email before replying All',                       Contact__c=earlId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Stop scheduling 7am meetings for the whole team',          Contact__c=earlId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(3)));
todos.add(new TODO__c(Title__c='Sleep in once. Just to see what happens.',                 Contact__c=earlId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(30)));
todos.add(new TODO__c(Title__c='Accept that not everyone functions at 5am',                Contact__c=earlId, Status__c='In Progress', Priority__c='Low',    DueDate__c=d.addDays(365)));

// Warren Peace — "War and Peace"
todos.add(new TODO__c(Title__c='Draft a 14-point memo about whether to change the printer paper',     Contact__c=warrenId, Status__c='In Progress', Priority__c='High',   DueDate__c=d.addDays(3)));
todos.add(new TODO__c(Title__c='Resolve the Great Meeting Room Conflict of the 3rd Floor',            Contact__c=warrenId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Write peace treaty with IT over shared drive naming conventions',      Contact__c=warrenId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Negotiate a ceasefire in the break room fridge territorial dispute',   Contact__c=warrenId, Status__c='In Progress', Priority__c='High',   DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Stop turning every status update into a 40-slide presentation',       Contact__c=warrenId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(5)));
todos.add(new TODO__c(Title__c='Declare victory in the project that ended six months ago',            Contact__c=warrenId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(14)));
todos.add(new TODO__c(Title__c='Mediate the ongoing conflict between Slack and email users',          Contact__c=warrenId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(4)));
todos.add(new TODO__c(Title__c='Stop treating every retro as a war crimes tribunal',                  Contact__c=warrenId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Broker agreement on the correct way to load the dishwasher',          Contact__c=warrenId, Status__c='In Progress', Priority__c='Low',    DueDate__c=d.addDays(30)));
todos.add(new TODO__c(Title__c='Accept that some battles are not worth winning. Name three.',         Contact__c=warrenId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(10)));

// Mona Lott — "Moaning a lot"
todos.add(new TODO__c(Title__c='Find one thing at work that is not a catastrophe. Write it down.',    Contact__c=monaId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='File formal complaint about the coffee machine temperature (again)',   Contact__c=monaId, Status__c='In Progress', Priority__c='High',   DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Reply to that email without using the phrase frankly unacceptable',   Contact__c=monaId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(3)));
todos.add(new TODO__c(Title__c='Practise starting a sentence with something positive',                 Contact__c=monaId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Update the list of grievances from Q3 (Q4 has been added)',           Contact__c=monaId, Status__c='In Progress', Priority__c='Medium', DueDate__c=d.addDays(5)));
todos.add(new TODO__c(Title__c='Stop sighing loudly enough to be heard on the other floor',           Contact__c=monaId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Attend one meeting without saying this could have been an email',     Contact__c=monaId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(4)));
todos.add(new TODO__c(Title__c='Write a complaint. Then delete it. Then sleep.',                      Contact__c=monaId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Talk to someone who is not also complaining',                         Contact__c=monaId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(14)));
todos.add(new TODO__c(Title__c='Admit that one time things went better than expected',                Contact__c=monaId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(30)));

// Hugo First — "You go first"
todos.add(new TODO__c(Title__c='Volunteer for something before being voluntold',                      Contact__c=hugoId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Do not ask who is leading the initiative if you suggested it',        Contact__c=hugoId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Take the first parking spot instead of circling for 20 minutes',     Contact__c=hugoId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Order at the restaurant before everyone else finishes eating',        Contact__c=hugoId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(3)));
todos.add(new TODO__c(Title__c='Present slide deck you created and then handed to someone else',      Contact__c=hugoId, Status__c='In Progress', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Stop saying let me know how that goes when it was your idea',         Contact__c=hugoId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(5)));
todos.add(new TODO__c(Title__c='Enter the elevator first. Just once.',                                Contact__c=hugoId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(14)));
todos.add(new TODO__c(Title__c='Answer the question in the meeting instead of redirecting it',        Contact__c=hugoId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Stop saying after you to the person already walking through the door',Contact__c=hugoId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Own a decision from start to finish. Both parts.',                    Contact__c=hugoId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(10)));

// Percy Vere — "Persevere"
todos.add(new TODO__c(Title__c='Keep going on the migration task that has defeated three engineers',  Contact__c=percyId, Status__c='In Progress', Priority__c='High',   DueDate__c=d.addDays(3)));
todos.add(new TODO__c(Title__c='Re-read the error message for the 47th time — maybe it changed',     Contact__c=percyId, Status__c='In Progress', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Try the same password again but with more confidence',                Contact__c=percyId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Submit the form that rejected you four times — destiny favours the persistent',  Contact__c=percyId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(5)));
todos.add(new TODO__c(Title__c='Finish reading the documentation all the way to page 2',             Contact__c=percyId, Status__c='In Progress', Priority__c='Medium', DueDate__c=d.addDays(4)));
todos.add(new TODO__c(Title__c='Revisit the business case that was rejected twice — third time lucky',Contact__c=percyId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Reconnect with the vendor who ghosted you for 3 weeks',              Contact__c=percyId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(6)));
todos.add(new TODO__c(Title__c='Keep updating the status report even if no one reads it',             Contact__c=percyId, Status__c='In Progress', Priority__c='Low',    DueDate__c=d.addDays(30)));
todos.add(new TODO__c(Title__c='Try the IKEA instructions one more time without skipping steps',      Contact__c=percyId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(14)));
todos.add(new TODO__c(Title__c='Accept that some things take time. Then try again immediately.',      Contact__c=percyId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(1)));

// Al Zeimers — "Alzheimer's"
todos.add(new TODO__c(Title__c='Write down why you walked into this room (do it now, not later)',     Contact__c=alId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Find keys. Check: pockets, bowl, fridge, car ignition.',             Contact__c=alId, Status__c='In Progress', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Re-read the email you replied to already (and replied to again)',     Contact__c=alId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Remember what the password hint means. The hint is password.',        Contact__c=alId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Check if you already made this TODO (you did)',                       Contact__c=alId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Recall the name of the colleague you have worked with for 3 years',  Contact__c=alId, Status__c='In Progress', Priority__c='Medium', DueDate__c=d.addDays(5)));
todos.add(new TODO__c(Title__c='Put phone somewhere memorable. Then remember where memorable is.',    Contact__c=alId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(3)));
todos.add(new TODO__c(Title__c='Figure out which tab has the music playing',                          Contact__c=alId, Status__c='In Progress', Priority__c='Low',    DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Remember dentist appointment before arriving a week early again',     Contact__c=alId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Write a note to yourself. Find the note you already wrote.',          Contact__c=alId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(4)));

// Wynn Dosaplikayshun — "Windows application"
todos.add(new TODO__c(Title__c='Restart. Then restart again. Then ask if it is fixed.',               Contact__c=wynnId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Respond to the update prompt with Remind me tomorrow for the 6th week',Contact__c=wynnId, Status__c='In Progress', Priority__c='Medium', DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Close 11 popups before getting to the actual work',                   Contact__c=wynnId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Investigate why the spinner is still spinning from yesterday',        Contact__c=wynnId, Status__c='In Progress', Priority__c='High',   DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Accept terms and conditions without reading (ritual complete)',        Contact__c=wynnId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(14)));
todos.add(new TODO__c(Title__c='Find out which startup app is adding 4 minutes to boot time',        Contact__c=wynnId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(5)));
todos.add(new TODO__c(Title__c='Click Not Now on the backup reminder. Next week: also Not Now.',      Contact__c=wynnId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Uninstall the toolbar you do not remember installing',                Contact__c=wynnId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(3)));
todos.add(new TODO__c(Title__c='Submit bug report using the form that is also bugged',                Contact__c=wynnId, Status__c='In Progress', Priority__c='Medium', DueDate__c=d.addDays(4)));
todos.add(new TODO__c(Title__c='Turn it off and on again. Document the result for science.',          Contact__c=wynnId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(30)));

// Dee Mandingboss — "Demanding boss"
todos.add(new TODO__c(Title__c='Send the report by EOD. All 6 versions. Formatted differently.',     Contact__c=deeId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Schedule the meeting about the meeting agenda before the pre-meeting',Contact__c=deeId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Reply ASAP to the email that was sent at midnight',                   Contact__c=deeId, Status__c='In Progress', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Revise the document. Tracked changes only. No, wait — clean copy.',  Contact__c=deeId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Build the feature by end of sprint. Sprint ends tomorrow.',          Contact__c=deeId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Make it pop but also make it professional — you know what I mean',    Contact__c=deeId, Status__c='In Progress', Priority__c='Medium', DueDate__c=d.addDays(3)));
todos.add(new TODO__c(Title__c='Reduce costs, increase output, maintain quality. Budget: zero.',      Contact__c=deeId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Re-do slide 7 in a completely different direction (again)',           Contact__c=deeId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(5)));
todos.add(new TODO__c(Title__c='Have it ready for the 8am call that was just moved to 7am',          Contact__c=deeId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Learn to say the timeline is not realistic before agreeing to it',    Contact__c=deeId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(30)));

// Constance Noring — "Constant snoring"
todos.add(new TODO__c(Title__c='Stay awake for the entire all-hands. Set 3 alarms.',                 Contact__c=constanceId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Apologise for falling asleep in the client presentation (again)',     Contact__c=constanceId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(2)));
todos.add(new TODO__c(Title__c='Book sleep study — colleague reported the sound on Zoom',            Contact__c=constanceId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(5)));
todos.add(new TODO__c(Title__c='Sit in the front row so falling asleep is not an option',            Contact__c=constanceId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(3)));
todos.add(new TODO__c(Title__c='Stop picking standing meetings when the goal is to stay awake',       Contact__c=constanceId, Status__c='In Progress', Priority__c='Low',    DueDate__c=d.addDays(7)));
todos.add(new TODO__c(Title__c='Drink the coffee before the meeting, not as a desperate mid-meeting gesture',Contact__c=constanceId, Status__c='Not Started', Priority__c='High', DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Turn camera OFF before drowsiness becomes a video moment',           Contact__c=constanceId, Status__c='Not Started', Priority__c='Medium', DueDate__c=d.addDays(4)));
todos.add(new TODO__c(Title__c='Mute microphone when eyes start to close in workshop',               Contact__c=constanceId, Status__c='Not Started', Priority__c='High',   DueDate__c=d.addDays(1)));
todos.add(new TODO__c(Title__c='Do not book 7am meetings then wonder why you crash by 9am',          Contact__c=constanceId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(14)));
todos.add(new TODO__c(Title__c='Sleep 8 hours. Radical. Life-changing. Try it.',                     Contact__c=constanceId, Status__c='Not Started', Priority__c='Low',    DueDate__c=d.addDays(30)));

insert todos;
System.debug('TODOs inserted: ' + todos.size());
