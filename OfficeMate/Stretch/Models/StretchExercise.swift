import Foundation

struct StretchExercise: Identifiable {
    let id: Int
    let title: String
    let description: String
    let gifName: String
    let duration: Int
    
    static let exercises: [StretchExercise] = [
        StretchExercise(
            id: 1,
            title: "Head Side to Side",
            description: "Gently turn your head to the left,\nthen to the right. Repeat slowly.",
            gifName: "clean_single_nod_animation",
            duration: 15
        ),
        StretchExercise(
            id: 2,
            title: "Look Around",
            description: "Slowly look up and down,\nthen left and right.",
            gifName: "look_around_animation",
            duration: 15
        ),
        StretchExercise(
            id: 3,
            title: "Shoulder Drop",
            description: "Relax your shoulders and let them drop naturally.",
            gifName: "shoulder_drop_stretch_slow",
            duration: 15
        ),
        StretchExercise(
            id: 4,
            title: "Arm Raise",
            description: "Raise your arms above your head and stretch.",
            gifName: "arm_raise_stretch",
            duration: 15
        ),
        StretchExercise(
            id: 5,
            title: "Side Bend",
            description: "Gently bend to each side, keeping your back straight.",
            gifName: "side_bend_stretch",
            duration: 15
        ),
        StretchExercise(
            id: 6,
            title: "Celebration",
            description: "Great job! Let's celebrate your achievement!",
            gifName: "arm_raise_cheer",
            duration: 5
        )
    ]
} 