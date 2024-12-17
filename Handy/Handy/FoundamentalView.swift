//
//  FoundamentalView.swift
//  leARn
//
//  Created by Gennaro Liguori on 17/12/24.
//


import SwiftUI

struct SectionView: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
            
            Text(content)
                .font(.body)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .padding(.leading, 8)
                
            Divider()
        }
    }
}


struct FoundamentalView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Section
                Text("Augmented Reality Concepts")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 10)
                
                Divider()
                    .background(Color.gray)
                    
                SectionView(title: "1. Scene and ARView",
                            content: "The scene represents the AR environment where virtual objects are placed. ARView is the main view that displays and manages the scene, allowing you to add, remove, and interact with AR elements.")

                SectionView(title: "2. Entities",
                            content: "Entities are virtual objects in the AR scene. These can be 3D models, basic primitives like cubes or spheres, or custom objects with materials and animations.")
                
                SectionView(title: "3. Anchors",
                            content: "Anchors are real-world reference points where virtual entities attach. Common types include Plane Anchors, World Anchors, Image Anchors, and Object Anchors.")
                
                SectionView(title: "4. Materials and Shadows",
                            content: "Materials define the appearance of entities, such as color or texture. Shadows help integrate virtual objects visually into the real environment, enhancing realism.")
                
                SectionView(title: "5. Plane Detection",
                            content: "ARKit detects horizontal and vertical surfaces in the real world, enabling stable placement of virtual objects on these surfaces.")
                
                SectionView(title: "6. Interactions and Gestures",
                            content: "Users can interact with AR entities through gestures like tap (select), drag (move), or pinch (scale and rotate), making the experience dynamic and engaging.")
                
                SectionView(title: "7. Image and Object Anchoring",
                            content: "Anchoring based on images or objects allows overlaying virtual content on specific real-world references, like posters or models.")
                
                SectionView(title: "8. Lighting and Environment",
                            content: "ARKit captures ambient light and adapts the lighting on virtual entities, ensuring visual consistency between the virtual and physical worlds.")
                
                SectionView(title: "9. Animations",
                            content: "Animations bring virtual objects to life by adding movement, transformations, and effects to enhance immersion.")
                
                SectionView(title: "10. AR Session and Tracking",
                            content: "The AR session manages camera tracking and device motion, enabling accurate understanding of the real-world environment and virtual object placement.")
                
                SectionView(title: "11. Reality Composer",
                            content: "Reality Composer is a visual tool to design AR scenes, entities, and behaviors, making AR development faster and easier.")
            }
            .padding()
        }
        .background(Color(UIColor.systemGray6))
    }
}
#Preview {
    FoundamentalView()
}
