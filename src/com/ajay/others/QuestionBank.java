package com.ajay.others;
import java.util.HashMap;
import java.util.Map;

import com.conf.component.Questions;

public class QuestionBank {
	Map<Integer, Questions> questionMap = new HashMap<>();
	private static QuestionBank questionBank = new QuestionBank();
	
	private QuestionBank() {
		setQuestions();
	}
	
	public static QuestionBank getInstance() {
		return questionBank;
	}
	
	public Questions getQuestion(Integer qNum) {
		//System.out.println("Question called");
		return questionMap.get(qNum);
	}
	
	public Map<Integer, Questions> getQuestionMap() {
		return questionMap;
	}

	public void setQuestionMap(Map<Integer, Questions> questionMap) {
		this.questionMap = questionMap;
	}
	
	public String getQuestionStatement(Integer qNum) {
		return questionMap.get(qNum).getQuestion();
	}

	private void setQuestions() {
		createQuestion(1,"How was your experience?",new String[]{"GOOD","OK","BAD"});
		createQuestion(2,"How was the sanitation in the Hospital?",new String[]{"GOOD","OK","BAD"});
		createQuestion(3,"How was the Food?",new String[]{"GOOD","OK","BAD"});
		createQuestion(4,"How was the experience with the Doctors?",new String[]{"GOOD","OK","BAD"});
		createQuestion(5,"Would you like to donate Plasma to save someone's life?",new String[]{"Yes","No"});
	}
	public Questions createQuestion(int id, String name, String ...choices) {
		Questions q = new Questions();
		q.setId(id);
		q.setQuestion(name);
		for(String choice: choices) {
			q.getChoices().add(choice);
		}
		questionMap.put(q.getId(),q);
		return q;
	}
}
