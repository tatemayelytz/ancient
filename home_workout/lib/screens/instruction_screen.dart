import 'package:flutter/material.dart';

class Instructions extends StatelessWidget {
  static String id = 'instructionsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises Instructions'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ExerciseDescription(
                  title: 'Jumping Jacks',
                  description:
                      'Start with your feet together and your arms by your sides, then jump up with your feet apart and your hands overhead. Return to the starting position and repeat the exercise.',
                  imgName: 'JUMPING JACKS.gif'),
              ExerciseDescription(
                  title: 'Wall sit',
                  description:
                      'Start with your back against a wall, then slide down until your knees are at a 90 degree angle. Keep your back against the wall with your arms and hands away from your legs. Hold this position.',
                  imgName: 'WALL SITS.png'),
              ExerciseDescription(
                  title: 'Push ups',
                  description:
                      'Lay prone on the ground with arms supporting your body. Keep your body straight while raising and lowing your body with your arms.',
                  imgName: 'PUSH UPS.gif'),
              ExerciseDescription(
                  title: 'Crunches',
                  description:
                      'Lie on your back with your knees bent and your arms stretched forward. Then lift your upper body off the floor. Hold for a few seconds and return slowly.',
                  imgName: 'CRUNCHES.gif'),
              ExerciseDescription(
                  title: 'Step up onto chair',
                  description:
                      'Stand in front of a chair. Then step up on the chair and step back down.',
                  imgName: 'STEP UP ONTO CHAIR.gif'),
              ExerciseDescription(
                  title: 'Squats',
                  description:
                      'Stand with your feet shoulder width apart and your arms stretched forward, then lower your body until your thighs are parallel with the floor. Your knees should be extended in the same direction as your toes. Return to the start position and repeat the exercise.',
                  imgName: 'SQUATS.gif'),
              ExerciseDescription(
                  title: 'Tricep Dips',
                  description:
                      'For the start position, sit on the chair. Then move your hip off the chair with your hands holding the edge of the chair. Slowly bend and stretch your arms to make your body go up and down.',
                  imgName: 'TRICEP DIPS.gif'),
              ExerciseDescription(
                  title: 'Plank',
                  description:
                      'Lie on the floor with your toes and forearms on the ground. Keep your body straight and hold this position as long as you can.',
                  imgName: 'PLANK.png'),
              ExerciseDescription(
                  title: 'High Stepping',
                  description:
                      'Run in place while pulling your knees as high as possible with each step. Keep your body upright during this exercise.',
                  imgName: 'HIGH STEPPING.gif'),
              ExerciseDescription(
                  title: 'Lunges',
                  description:
                      'Stand with your feet shoulder width apart and your hands on your hips. Take a step forward with your right leg and lower your body until your right thigh is parallel with the floor. Then return and switch to the other leg.',
                  imgName: 'LUNGES.gif'),
              ExerciseDescription(
                  title: 'Push-up and Rotation',
                  description:
                      'Start in the push-up position. Then go down for a push-up and as you come up, rotate your upper body and extend your arm upwards. Repeat the exercise with the other arm.',
                  imgName: 'PUSH UP AND ROTATION.gif'),
              ExerciseDescription(
                  title: 'Side plank right',
                  description:
                      'Lie on your right side with your forearm supporting your body. Hold your body in a straight line.',
                  imgName: 'SIDE PLANK RIGHT.png'),
              ExerciseDescription(
                  title: 'Side plank left',
                  description:
                      'Lie on your left side with your forearm supporting your body. Hold your body in a straight line.',
                  imgName: 'SIDE PLANK LEFT.png'),
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseDescription extends StatelessWidget {
  String title;
  String description;
  String imgName;

  ExerciseDescription({
    required this.title,
    required this.description,
    required this.imgName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          description,
        ),
        Image.asset('images/' + imgName),
      ],
    );
  }
}
