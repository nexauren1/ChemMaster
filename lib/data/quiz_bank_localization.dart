import 'quiz_bank.dart';
import 'curriculum_localization.dart';

class QuizTranslation {
  final String prompt;
  final List<String> options;
  final String explanation;
  const QuizTranslation(this.prompt, this.options, this.explanation);
}

const englishQuiz = <String, QuizTranslation>{
  'q1': QuizTranslation('What is the chemical formula for water?',['H₂O','CO₂','O₂','NaCl'],'A water molecule contains two hydrogen atoms and one oxygen atom.'),
  'q2': QuizTranslation('Which equation correctly balances the formation of water?',['H₂ + O₂ → H₂O','2H₂ + O₂ → 2H₂O','H₂ + 2O₂ → H₂O','2H₂ + 2O₂ → H₂O'],'There are four hydrogen atoms and two oxygen atoms on each side.'),
  'q3': QuizTranslation('Water and oil form which type of mixture?',['Homogeneous','Heterogeneous','Pure substance','Element'],'The two visible phases are distinct.'),
  'q4': QuizTranslation('The atomic number corresponds to the number of:',['Neutrons','Protons','Molecules','Shells'],'The number of protons identifies the chemical element.'),
  'q5': QuizTranslation('Which expression relates amount of substance, mass and molar mass?',['n = m/M','n = m × M','M = n/m','m = n/M'],'The amount of substance is mass divided by molar mass.'),
  'q6': QuizTranslation('Which type of bond predominates in sodium chloride?',['Covalent','Metallic','Ionic','Nuclear'],'NaCl is formed from Na⁺ and Cl⁻ ions.'),
  'q7': QuizTranslation('What products form from HCl + KOH?',['KCl + H₂O','KOH + Cl₂','H₂ + KCl','K₂O + HCl'],'Hydrochloric acid and potassium hydroxide form potassium chloride and water.'),
  'q8': QuizTranslation('What is the name of KOH?',['Potassium oxide','Potassium acid','Potassium hydroxide','Potassium chloride'],'KOH is potassium hydroxide.'),
  'q9': QuizTranslation('Which formula represents ethene?',['C₂H₆','C₂H₄','C₂H₂','CH₄'],'Ethene is an alkene with one C=C double bond.'),
  'q10': QuizTranslation('Fe₂O₃ is called:',['Iron(III) oxide','Iron acid','Iron hydroxide','Iron chloride'],'Oxygen has oxidation number −2; iron is +3 in this compound.'),
  'q11': QuizTranslation('In 2H₂ + O₂ → 2H₂O, what is the H₂:O₂ mole ratio?',['1:1','2:1','1:2','2:2'],'The coefficients show a ratio of 2 mol H₂ to 1 mol O₂.'),
  'q12': QuizTranslation('What is the formula for sulfur dioxide?',['SO','SO₂','SO₃','H₂S'],'The prefix di- indicates two oxygen atoms: SO₂.'),
  'q13': QuizTranslation('Which functional group characterises alcohols?',['Carboxyl','Hydroxyl','Aldehyde','Ester'],'Alcohols contain a hydroxyl group attached to a saturated carbon.'),
  'q14': QuizTranslation('The atomic number of an element indicates the number of:',['Neutrons','Protons','Energy levels','Isotopes'],'The number of protons defines the identity of the element.'),
  'q15': QuizTranslation('Which bond involves sharing pairs of electrons?',['Ionic','Covalent','Metallic','Nuclear'],'In a covalent bond, atoms share electron pairs.'),
  'q16': QuizTranslation('A 2 mol/L solution is diluted from 50 mL to 100 mL. What is the final concentration?',['0.5 mol/L','1 mol/L','2 mol/L','4 mol/L'],'C₂ = C₁ × V₁ / V₂ = 2 × 50 / 100 = 1 mol/L.'),
  'q17': QuizTranslation('An exothermic reaction generally has:',['Positive ΔH','Negative ΔH','ΔH equal to zero','No energy exchange'],'An exothermic reaction releases energy and has a negative ΔH.'),
  'q18': QuizTranslation('Which factor can increase the rate of many reactions?',['Lowering temperature','Increasing temperature','Removing a reactant','Reducing surface area'],'Increasing temperature tends to increase the frequency of effective collisions.'),
  'q19': QuizTranslation('At dynamic equilibrium, the forward and reverse reaction rates are:',['Zero','Equal','Always different','Unrelated'],'The reactions continue, but the forward and reverse rates are equal.'),
  'q20': QuizTranslation('At 25 °C, which relationship is usually valid in a dilute aqueous solution?',['pH + pOH = 7','pH + pOH = 14','pH = pOH always','pH × pOH = 14'],'At 25 °C, the ionic product of water gives pH + pOH = 14.'),
  'q21': QuizTranslation('In a galvanic cell, oxidation occurs at the:',['Cathode','Anode','Electrolyte only','Salt bridge'],'The anode is the electrode where oxidation occurs.'),
  'q22': QuizTranslation('Proteins are natural polymers made from:',['Monosaccharides','Amino acids','Fatty acids','Nucleotides'],'Proteins are chains of amino acids joined by peptide bonds.'),
};

QuizQuestion localizedQuizQuestion(QuizQuestion question, bool english) {
  if (!english) return question;
  final translation = englishQuiz[question.id];
  if (translation == null) return question;
  return QuizQuestion(
    question.id,
    localizedGrade(question.grade, true),
    question.unit,
    translation.prompt,
    translation.options,
    question.answer,
    translation.explanation,
  );
}
