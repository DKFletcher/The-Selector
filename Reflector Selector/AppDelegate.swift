//
//  AppDelegate.swift
//  WML
//
//  Created by Donald Fletcher on 30/01/2020.
//  Copyright © 2020 Donald Fletcher. All rights reserved.
//
import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	let testAnswer : String = ""//Alice was beginning to get very tired of sitting by her sister on the bank, and of having nothing to do: once or twice she had peeped into the book her sister was reading, but it had no pictures or conversations in it, 'and what is the use of a book,' thought Alice 'without pictures or conversation?'\nSo she was considering in her own mind (as well as she could, for the hot day made her feel very sleepy and stupid), whether the pleasure of making a daisy-chain would be worth the trouble of getting up and picking the daisies, when suddenly a White Rabbit with pink eyes ran close by her.\nThere was nothing so very remarkable in that; nor did Alice think it so very much out of the way to hear the Rabbit say to itself, 'Oh dear! Oh dear! I shall be late!' (when she thought it over afterwards, it occurred to her that she ought to have wondered at this, but at the time it all seemed quite natural); but when the Rabbit actually took a watch out of its waistcoat-pocket, and looked at it, and then hurried on, Alice started to her feet, for it flashed across her mind that she had never before seen a rabbit with either a waistcoat-pocket, or a watch to take out of it, and burning with curiosity, she ran across the field after it, and fortunately was just in time to see it pop down a large rabbit-hole under the hedge.In another moment down went Alice after it, never once considering how in the world she was to get out again.\nThe rabbit-hole went straight on like a tunnel for some way, and then dipped suddenly down, so suddenly that Alice had not a moment to think about stopping herself before she found herself falling down a very deep well."
	//	let testAnswer : String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus justo nisl, finibus a nisl ac, aliquam auctor nisl. Mauris venenatis malesuada commodo. Sed vestibulum sed tellus vel condimentum. Nullam sed pretium est. Morbi lobortis nisl dui, ultrices tempor ex maximus a. In quam nisi, mattis id posuere eget, gravida ut enim. Integer cursus fringilla nulla, quis rhoncus sapien. Vivamus maximus est vitae erat faucibus, dapibus varius sem sodales.\nDonec bibendum pharetra libero, quis pretium ipsum imperdiet vel. Donec ornare lacus et elit interdum ultrices. Vestibulum vestibulum mauris et erat cursus, a pretium dolor laoreet. Fusce non ligula nisi. Donec non porttitor lacus. Sed vehicula, ipsum vitae laoreet pharetra, quam tellus dapibus neque, ut porta libero dolor vel magna. Sed laoreet nisl id fermentum facilisis. Fusce nibh massa, bibendum ac dui sed, congue interdum lectus. Integer venenatis pulvinar massa, sit amet lobortis enim dignissim eu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vivamus massa mauris, sagittis quis lorem vitae, semper accumsan orci. Nam tempus ut massa nec facilisis. Duis sagittis sagittis tortor, ac rutrum tellus sagittis non."
	
	func applicationDidFinishLaunching(_: UIApplication) {
		(window!.rootViewController as! TabBarController).emotions =
			[EmotionItems(
				called: "Admiring",
				feels: ["we see other people’s good qualities."],
				motive: ["Liking the qualities of others; it inspires us to want to be like them."],
				behaviour: ["look at and look up to the people we admire, we want to learn from them, try to be like them. It feeds into and is directed by our determination."],
				solution: ["Uplift ourselves through admiration."],
				stage : .third,
				ring: .stretchingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel admiration?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt admiriation what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me admiration is…", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling admiration make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling admiration?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you make the most of feeling admiration?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Angry",
				feels: ["we feel treated unfairly or with disrespect. Or we see others being treated unfairly."],
				motive: ["Believing there has been unfairness; it drives us to act and restore fairness and achieve justice."],
				behaviour: ["try to sort things out, to stop future unfairness or people taking advantage of us. We defend ourselves and those we care about, improve our performance, or make ourselves appear powerful."],
				solution: ["Channel anger to restore justice."],
				stage : .first,
				ring: .meFirst,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel angry?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt angry what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling angry is…", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling angry make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling angry?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling angry?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Arrogant",
				feels: ["we see ourselves as superior, better than everyone else."],
				motive: ["Feeling we are better than everyone else. It entices us to behave as if we are the most important."],
				behaviour: ["think we are always right, dominate or isolate others to hold onto our status and power, to stay ‘top dog’."],
				solution: ["Puncture arrogance with humility."],
				stage : .third,
				ring: .meFirst,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel arrogant?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt arrogant what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me arrogance is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling arrogant make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling arrogant?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling arrogant?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Belonging",
				feels: ["we feel that we fit in, we are close to others and feel secure with them."],
				motive: ["Feeling secure and accepted; it encourages us to look out for our group."],
				behaviour: ["seek the best for the group we belong to, we feel kindly disposed to the group and share with them and care for them. It makes us feel content. "],
				solution: ["Feel secure through belonging."],
				stage : .second,
				ring: .connectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel you belong?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt you belong what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling a sense of belonging is…", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling a sense of belonging make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling a sense of belonging?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the most from a sense of belonging?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Bold",
				feels: ["we have a new opportunity or need to take up a risky challenge, or we are being evaluated and we overcome our fear."],
				motive: ["fearing danger or the unknown, we overcome fear; it spurs us to take risks."],
				behaviour: ["confront the danger, face the unknown or the pain. It functions like a turbo charged confidence."],
				solution: ["Overcome fear through courage."],
				stage : .second,
				ring: .stretchingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel brave?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt bold what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling bold & brave is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling bold make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling brave?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get a sense of courage?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Bored",
				feels: ["we feel we have nothing to do, or nothing on offer appeals to us, we feel trapped and lack any focus."],
				motive: ["Feeling stuck in a dull situation; it pushes us to look to change things."],
				behaviour: ["try to change things, look for alternatives, sometimes we can become rude or aggressive."],
				solution: ["Use boredom as time to think."],
				stage : .second,
				ring: .meFirst,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel bored?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt bored what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling bored is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling bored make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling bored?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling bored?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Compassionate",
				feels: ["we notice when others are in need or upset."],
				motive: ["Feeling the suffering of others; it compels us to want to help them."],
				behaviour: ["want to do something to help others. It makes us look out for others, as well as ourselves, and want to alleviate suffering."],
				solution: ["Care for others with compassion."],
				stage : .third,
				ring: .connectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel compassionate?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt compassionate what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me compassion is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does compassion make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling compassionate?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the most of your sense of compassion?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Confident",
				feels: ["we believe we are able to cope with what we have to do and we don’t doubt ourselves."],
				motive: ["Feeling able to do what we need to do, it enables us to feel ready for the challenge."],
				behaviour: ["believe in ourselves and embrace challenges, thinking we can succeed."],
				solution: ["Tackle challenges with confidence."],
				stage : .second,
				ring: .stretchingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel confident?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt confident what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling confident is…", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling confident make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How does confidence feel in your body?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the most of your sense of confidence?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Contempt",
				feels: ["we judge others as failing to meet our standards, to be inferior, unimportant and of little value to us."],
				motive: ["Making someone feel useless so we can feel superior."],
				behaviour: ["look down on, sneer on, pick on, humiliate, ignore or exclude certain people, in order to ‘big up’ ourselves."],
				solution: ["Be helpful to those we feel contemptuous towards."],
				stage : .third,
				ring: .meFirst,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel contemptuous?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt contemptuous what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me contempt is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling contempt make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling contemptuous?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling contemptuous?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Content",
				feels: ["we are at ease with ourselves, our situation and relationships. All is well. We appreciate what we have, count our blessings and are happy with simple pleasures."],
				motive: ["Feeling secure and satisfied; it lets us value what we have and feel fulfilled. It turns what we have into enough."],
				behaviour: ["feel what we have and who we are with is enough, and so we make the most of what we have. It stops us taking people or things for granted. It also stops us bothering about how we compare to."],
				solution: ["Appreciate what we have through contentment."],
				stage : .first,
				ring: .connectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel content?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt content what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling content is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling content make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling content?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the most from feeling contentment?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Curious",
				feels: ["we need to know more about something, or find ourselves in new situations, or with tasks of interest to us."],
				motive: ["Being interested in things; it drives us to find out more."],
				behaviour: ["want to discover more about new places, objects or ideas."],
				solution: ["Explore our interests with curiosity."],
				stage : .first,
				ring: .stretchingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel curious?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt curious what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling curious is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling curious make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling curious?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the most from a sense of curiosity?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Determined",
				feels: ["we are up for an important challenge and we are keen to do well. We are trying to make something really important to us happen."],
				motive: ["Having a goal thats important to our worth; it commits us to grab the chance, and make sure we succeed."],
				behaviour: ["give our best and try our hardest. We keep going with the challenge."],
				solution: ["Direct our energy with determination."],
				stage : .second,
				ring: .stretchingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel determined?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt determined what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling determined is…", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling determined make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling determined?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the most from a sense of determination?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Embarrassed",
				feels: ["we are worried what people might think of us after making an awkward but small mistake, when we feel we have made a bit of a fool of ourselves, or we are embarrassed by people close to us."],
				motive: ["Feeling uncomfortably exposed; it nudges us to divert attention from ourselves as quickly as possible."],
				behaviour: ["apologise, make up for our mistake and do what is expected. We may cover our face, letting others know we are aware of our mistake, that it was something we didn’t mean to do. All this is in order to restore our reputation."],
				solution: ["Bounce back from embarrassment with humour."],
				stage : .first,
				ring: .protectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel embarrassed?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt embarrassed what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling embarrassed is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling embarrassed make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling embarrassed?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling embarrassed?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Empathetic Joy",
				feels: ["we see that something good has happened to others, and we are completely devoid of jealousy or envy."],
				motive: ["Feeling pleased for the success of others; it enables us to join in with their celebration."],
				behaviour: ["pleased for them and we enjoy and celebrate their success with them, and so can feel part of a successful group."],
				solution: ["Share in others’ success with empathetic joy."],
				stage : .third,
				ring: .connectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel empathetic joy?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt empathetic joy what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me empathetic joy is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does empathetic joy make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling empathetic joy?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the most from feeling empathetic joy?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Enthusiastic",
				feels: ["we are in a new or challenging situation, we might not be sure what will happen, but we think it is going to be good, and we can’t wait to begin."],
				motive: ["Feeling that something good is going to happen; it energises us to grab the opportunity."],
				behaviour: ["go for it, embrace the opportunity and drive forward."],
				solution: ["Prime ourselves with enthusiasm."],
				stage : .first,
				ring: .stretchingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel excited?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt excited what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling excited is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling excitement make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling excited?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the nost from a sense of excitement?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Entitled",
				feels: ["we assume others will see us as superior and more privileged than everyone else."],
				motive: ["Seeing ourselves as more privileged than everyone else; we demand special treatment."],
				behaviour: ["expect that others will treat us as special and to get our own way. We ignore people we don’t rate. We make unrealistic demands on others, ignore rules and offend people. We feel angry if we don’t get our own way."],
				solution: ["Put entitled in its place with grace."],
				stage : .third,
				ring: .meFirst,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel entitled?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt entitled what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me entitlement is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling entitled make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling entitled?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling entitled?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Envy",
				feels: ["we feel discontent at what we lack in comparison to others, we want something we don’t and perhaps can’t have; others have what we want and we think we should be able to have it."],
				motive: ["Comparing ourselves to others who have better qualities, achievements or possessions. It goads us to want to get what they have and be like them."],
				behaviour: ["feel life is not fair. We feel grudging and hostile to those who have what we want. Or it can drive us to make up for our limitations."],
				solution: ["Reframe envy as admiration."],
				stage : .second,
				ring: .meFirst,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel envious?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt envious what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling envious is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling envious make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling envious?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling envious?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Forgiveness",
				feels: ["someone has done us wrong or offended us, but we choose to be whole hearted and kind and avoid making a fuss."],
				motive: ["Feeling hurt by others and choosing to be kind, in order to maintain peace and stay friends."],
				behaviour: ["able to rise above an offence or disagreement and let it go, rather than hold a grudge or persist with the argument."],
				solution: ["Restore harmony with forgiveness."],
				stage : .third,
				ring: .connectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel forgiving?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt forgiving what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling forgiving is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling forgiving make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling forgiveness?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the most from feeling forgiving?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Frustrated",
				feels: ["we are blocked from getting on with things, for example, when the computer goes very slowly."],
				motive: ["Feeling blocked from doing what we want; it jostles us to do something to try to sort the problem."],
				behaviour: ["try to sort the problem and remove what is stopping us, or give up, or get back at the person or thing that is blocking us."],
				solution: ["Contain frustration by staying in the moment."],
				stage : .first,
				ring: .meFirst,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel frustrated?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt frustrated what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling frustrated is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling frustrated make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling frustrated?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling frustrated?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Gloating",
				feels: ["we see something unfortunate has happened to others, especially someone we dislike, envy, or resent or with whom we are competing. It reduces their advantage over us."],
				motive: ["Being pleased at others misfortune; it lets us feel better about ourselves."],
				behaviour: ["take pleasure at their misfortune and so feel relieved, if not superior."],
				solution: ["Focus on camaraderie to eclipse gloating."],
				stage : .third,
				ring: .meFirst,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel gloating?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt gloating what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me gloating is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does gloating make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling gloating?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of gloating?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Guilty",
				feels: ["we feel upset about letting ourselves or others down, for doing something wrong or for not doing something we should - even if no-one else knows about it."],
				motive: ["Feeling sorry for doing something wrong; it compels us to make up for what we’ve done wrong."],
				behaviour: ["confess, apologise or do something to make up for our wrongdoing. It can stop us thinking about anything else. It makes us realise we are responsible for our behaviour."],
				solution: ["Resolve guilt by making amends."],
				stage : .second,
				ring: .protectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel guilty?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt guilty what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling guilty is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling guilty make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling guilty?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling guilty?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Hopeful",
				feels: ["we are not sure what will happen, but we believe that life makes sense and things will turn out alright."],
				motive: ["We believe things will work out well; it helps us to look to the future."],
				behaviour: ["believe there are people and values worth working for, and so we want to keep going."],
				solution: ["Embrace the future with hope."],
				stage : .third,
				ring: .stretchingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel hopeful?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt hopeful what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me hope is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling hope make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling hopeful?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the most from a sense of hope?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Humiliated",
				feels: ["people put us down unfairly and in public, and we are made to feel less worthy than we feel our self to be."],
				motive: ["Being made to feel worthless; it leaves us wanting to hide or get back at those who humiliated us."],
				behaviour: ["hate those who are getting at us: we want to either seek revenge or escape. It can jolt us into defending ourselves or facing up to our shortcomings."],
				solution: ["Find relief from humiliation in humility. "],
				stage : .third,
				ring: .protectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel humiliated?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt humiliated what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me humiliation is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does humiliation make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling humiliated?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling humiliated?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Inferior",
				feels: ["we feel less important or less able than others, and we are taken for granted or not taken seriously."],
				motive: ["Feeling overlooked and less important than everyone else; it causes us to keep to ourselves."],
				behaviour: ["put ourselves down, think we are unworthy, hide or keep to ourselves. We take part as little as possible to avoid further damage to ourselves or the group."],
				solution: ["If ignored or feeling inferior, hold on to what’s important."],
				stage : .third,
				ring: .protectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel ignored?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt ignored what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me being ignored is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does being ignored make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling ignored?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling ignored or inferior?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Joy",
				feels: ["we are doing things we really like and we are doing well; it’s even better than we imagined."],
				motive: ["Loving what is happening and how well we are all doing; it makes us feel uplifted and want more of the experience."],
				behaviour: ["want more of this and seize opportunities. It helps us be creative and seek new possibilities."],
				solution: ["Enjoy moments of exhilaration."],
				stage : .first,
				ring: .stretchingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel joyful?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt joyful what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling joyfull is..", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling joyful make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling joyful?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the most from a sense of joy?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Kind",
				feels: ["we feel warmth for others."],
				motive: ["Feeling goodwill towards others; it pushes us to want to do things for them, so we can show our affection and strengthen our connection."],
				behaviour: ["try to include and make people welcome, do things for and care for others, and give to them willingly without expecting anything in return."],
				solution: ["Share our strength with others through kindness."],
				stage : .first,
				ring: .connectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel kind?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt kind what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling kind is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling kind make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling kind?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get them most from feelings of kindness?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Lonely",
				feels: ["we feel no-one else likes us, or nobody is there for us."],
				motive: ["Feeling cut off from others; it makes us try to connect with people."],
				behaviour: ["try to re-connect, or use the space and time to work out what is important to us."],
				solution: ["Befriend ourselves when lonely."],
				stage : .first,
				ring: .protectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel lonely?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt lonely what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling lonely is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling lonely make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling lonely?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling lonely?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Overwhelmed",
				feels: ["everything feels out of control. We feel trapped and expect the worst to happen."],
				motive: ["Feeling everything is too much for us; it forces us to get things in perspective and get back some control."],
				behaviour: ["feel like giving up. We lose energy and interest in activities. We realise we need to get things in perspective and work out what is most important to us. We need to do something to feel some sense of control."],
				solution: ["Act in hope when overwhelmed."],
				stage : .third,
				ring: .protectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel overwhelmed?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt overwhelmed what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me being overwhelmed is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does being overwhelmed make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling overwhelmed?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling overwhelmed?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Playfulness",
				feels: ["we are having fun with others and not taking ourselves to seriously."],
				motive: ["Feeling comfortable with others; it lets us have fun with them and builds trust."],
				behaviour: ["feel comfortable with and like one another; we can drop our guard, we want to spend time with others, work hard for each other and contribute to the group goal."],
				solution: ["Have fun with others through playfulness."],
				stage : .first,
				ring: .connectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel playful?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt playful what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling playful is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling playful make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling playful?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the most from feeling playful?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Proud",
				feels: ["we have overcome a challenge, either by ourselves or through others. We are the person we want to be."],
				motive: ["Feeling pleased with ourselves; it pushes us to stretch ourselves further."],
				behaviour: ["realise our success is largely down to ourselves. We celebrate. We develop our skills to seek further success. It helps build our confidence and raise our status."],
				solution: ["Credit ourselves for success with Pride."],
				stage : .second,
				ring: .stretchingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel proud?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt proud what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling proud is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling proud make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling proud?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the most from a sense of pride?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Resentful",
				feels: ["we think we have been forced to accept something that has been imposed on us by people who have power over us. We think its unfair."],
				motive: ["Grudging having to put up with something done by someone with an unfair advantage over us; it cajoles us to make them suffer as much as we can get away with. "],
				behaviour: ["feel hard done-by, but we don’t say what the problem is. Instead we nurse our bitterness and criticise people indirectly, so we can feel self-righteously superior."],
				solution: ["Let go of bitterness by being honest with those we resent."],
				stage : .third,
				ring: .meFirst,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel resentful?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt resentful what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me resentment is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling resentful make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling resentful?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling resentful?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Responsible",
				feels: ["we want to play our part and do what we ought to do."],
				motive: ["We want to contribute and feel valued; we pay attention to how we affect others."],
				behaviour: ["take care over our choices. We are able to balance our interests with others’ interests. We think about the consequences of out actions, especially how they will affect others."],
				solution: ["Choose wisely by being responsible."],
				stage : .second,
				ring: .connectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel responsible?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt responsible what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling responsible is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling responsible make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling responsible?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the most from a sense of responsibility?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Sad",
				feels: ["we experience separation or loss, or feel let down. Something important has gone from our life. We lose our strength, appetite, or our capacity to enjoy life."],
				motive: ["Experiencing the pain of loss; it helps us to gradually come to terms with our loss."],
				behaviour: ["want to be on our own and rest, seek comfort and consolation and try to get things in perspective."],
				solution: ["Give ourselves time and space for sadness."],
				stage : .first,
				ring: .protectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel sad?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt sad what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling sad is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling sad make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling sad?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling sad?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Self-Doubting",
				feels: ["we are being tested and not sure of our own ability or worth, not sure if we are good enough."],
				motive: ["Feeling unsure of ourselves; it tugs us to work out how to improve."],
				behaviour: ["takes stock and ask questions, and try to work out how we can improve ourselves. It can also make us cautious and avoid risky challenges."],
				solution: ["Over-ride self-doubt with enthusiasm."],
				stage : .third,
				ring: .protectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel self-doubt?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt self-doubt what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling self-doubt is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling self-doubt make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling self-doubt?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling self-doubt?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Shame",
				feels: ["we see ourselves as an unworthy person and / or think other people know something bad about us. We feel we have let others down."],
				motive: ["Feeling exposed as a bad person; it is the fear of disconnection, of not being good enough. It forces us to face up to our failings."],
				behaviour: ["want to hide or escape; we worry about and / or face up to what’s wrong with us."],
				solution: ["Embrace the empathy of others to tame our shame."],
				stage : .third,
				ring: .protectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel ashamed?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt ashamed what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me shame is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does shame make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling ashamed?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling ashamed?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Spiteful",
				feels: ["we feel wronged or disrespected by someone."],
				motive: ["Feeling wronged by peers and we want to harm them, to show we are just as good as, if not better than, them."],
				behaviour: ["try to harm the person. At its extreme, it drives us to quash and gain power over those we feel have wronged us. This can often be self-destructive."],
				solution: ["Address the hostility that is causing us spite."],
				stage : .third,
				ring: .meFirst,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel spiteful?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt spiteful what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me spiteful is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does spite make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling spiteful?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling spiteful?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Thankful",
				feels: ["someone helps us or gives us something, or we realise how lucky we are. We get perhaps more than we think we deserve."],
				motive: ["Realising our good fortune and the kindness of others; it makes us give back."],
				behaviour: ["appreciate the benefits of kindness, of the good things that happen to us and our relationships. It encourages us to tell people how much we appreciate what they have done for us, and to give back in order to return their kindness."],
				solution: ["Credit others for what they’ve given us by showing gratitude."],
				stage : .second,
				ring: .connectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel thankful?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt thankful what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feelinf thankful is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling thankful make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling thankful?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the most from feeling gratitude?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Trust",
				feels: ["we believe in others and that they will look after us."],
				motive: ["Believing others will treat us responsibly; it allows us to go along with them."],
				behaviour: ["feel content and safe, we are willing to depend on and be open to others. We are able to be vulnerable."],
				solution: ["Expect the best of others through trust."],
				stage : .second,
				ring: .connectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel trusting?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt trusting what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling trust is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling trust make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling trusting?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the most from a sense of trust?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Valued",
				feels: ["people listen to and trust us. We feel we are known, important to others and of worth. Consequently we get what we deserve. People believe they can count on us. They would miss us if we left."],
				motive: ["Feeling we matter to our group; it encourages us to make our fullest contribution."],
				behaviour: ["want to matter more and to continue to be significant to others, to make a difference, to work hard and do our best."],
				solution: ["Achieve significance by feeling valued."],
				stage : .third,
				ring: .stretchingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel valued?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt valued what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "For me feeling valued is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling valued make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling valued?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "How do you get the most from feeling valued?", answer : testAnswer)])
				),
			 
			 EmotionItems(
				called: "Worried",
				feels: ["we think something bad might happen, although we might not be sure what.","we see danger, we think we might get hurt, we feel something is out of out control, we might fail or be rejected."],
				motive: ["Feeling something is out of our control; it makes us try to regain control."],
				behaviour: ["avoid possible risks and problems, it leads us to warn others about danger. It can force us to get out of our comfort zone and do something to regain control.","escape or avoid situations, act to defend ourselves, try to cautiously regain control, or call for help."],
				solution: ["Dispel worry through determined action."],
				stage : .first,
				ring: .protectingMe,
				worksheet : Worksheet(topLeft: [QuestionAnswer(question : "What makes you feel afraid/worried?", answer : testAnswer)],
															topRight: [QuestionAnswer(question : "When have you felt afraid/worried what was happening?", answer : testAnswer)],
															middleLeft: [QuestionAnswer(question : "Fro me feeling afraid/worried is...", answer : testAnswer)],
															middleRight: [QuestionAnswer(question: "What does feeling afraid/worried make you do?", answer: testAnswer)],
															bottomLeft: [QuestionAnswer(question : "How do you know when you are feeling afraid/worried?", answer : testAnswer)],
															bottomRight: [QuestionAnswer(question : "What helps you get out of feeling worried or afraid?", answer : testAnswer)])
				)
				].map(Card.init)
		
		let documentsPath = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0]
		let url = URL(fileURLWithPath: documentsPath)
		let fileManager = FileManager.default
		
		
		
		
		if let enumerator: FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: url.path){
			let decoder = JSONDecoder()
			let jsonWorksheetsURL = FileManager.applicationSupportDirectoryURL
				.appendingPathComponent("worksheets")
				.appendingPathExtension("txt")
			do{
				let jsonData = try Data(contentsOf: jsonWorksheetsURL)
				let abstractedWorksheets = try decoder.decode(AbstractionLayerForText.self, from: jsonData)
				(window!.rootViewController as! TabBarController).abstractionLayer = abstractedWorksheets
			} catch {
				print(error)
			}
			
			let jsonWorkbookURL = FileManager.applicationSupportDirectoryURL
				.appendingPathComponent("workbook")
				.appendingPathExtension("txt")
			do{
				let jsonData = try Data(contentsOf: jsonWorkbookURL)
//				let abstractedWorkbook = try decoder.decode(AbstractionLayerForWorkbook.self, from: jsonData)
//				(window!.rootViewController as! TabBarController).abstractionLayerForWorkbook = abstractedWorkbook
			} catch {
				print(error)
			}
			
			var emotionsImages : [String] = []
			while let element = enumerator.nextObject() as? String { guard element.hasSuffix(".img") else { continue }
				emotionsImages.append(element)
			}
			for image in emotionsImages {
				let jsonImagesURL = FileManager.applicationSupportDirectoryURL
					.appendingPathComponent(image)
				do{
					print(image)
					let jsonData = try Data(contentsOf: jsonImagesURL)
					print("jsonData: \(jsonData.count)")
					let abstractedImage = try decoder.decode(AbstractionLayerForImage.self, from: jsonData)
					print("abstractedImage: \(abstractedImage.image.emotion)")
					print()
					(window!.rootViewController as! TabBarController).setAbstractionLayerForImage(image: abstractedImage)
				} catch {
					print(error)
				}
			}
		}
		
		
		
		
	}
	
	
	func applicationDidEnterBackground(_: UIApplication){
//		var bgTask = UIBackgroundTaskInvalid
		print("the right place")
	}
}
