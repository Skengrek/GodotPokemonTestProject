
using Godot;
using System;

public class player : KinematicBody2D
{
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";
    [Export] public int walkSpeed = 200;

    public const int tileSize = 32;
    public Vector2 velocity = new Vector2();
    private Vector2 oldVelocity = new Vector2();
    private AnimationTree _animationTree;
    private AnimationNodeStateMachinePlayback _stateMachine;

    private string actualState = "Idle";

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        _animationTree = GetNode<AnimationTree>("playerAnimTree");
        _stateMachine = (AnimationNodeStateMachinePlayback)_animationTree.Get("parameters/playback");
        _stateMachine.Start("Idle");

        oldVelocity = new Vector2(0, 0);
    }


    public override void _PhysicsProcess(float delta)
    {
        velocity = new Vector2();
        actualState = "Walking";
        if (Input.IsActionPressed("ui_right"))
            velocity.x += 1;

        else if (Input.IsActionPressed("ui_left"))
            velocity.x -= 1;

        else if (Input.IsActionPressed("ui_down"))
            velocity.y += 1;

        else if (Input.IsActionPressed("ui_up"))
            velocity.y -= 1;
        else{
            _stateMachine.Start("Idle");
            _animationTree.Set("parameters/Idle/blend_position", oldVelocity);
            actualState = "Idle";
        }

        if (actualState!="Idle"){
            if (_stateMachine.GetCurrentNode() == "Idle"){
                _stateMachine.Start("Walking");
            }
            _animationTree.Set("parameters/Walking/blend_position", velocity);
            oldVelocity = velocity;
            Vector2 speed = velocity.Normalized() * walkSpeed;    
            MoveAndSlide(speed);
        }
    }

    // private void manageStateMachine(bool move, bool) 

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
