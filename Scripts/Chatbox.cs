using Godot;
using System;

public class Chatbox : Control
{
    public RichTextLabel chatLog;
    public Label label;
    public LineEdit lineEdit;

    public string userName = "Armand";
    
    public Godot.Collections.Dictionary<string, object> categories = 
        new Godot.Collections.Dictionary<string, object>();

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {   
        // Generate Links to the Chatbox elements
        var root = GetTree().Root.GetNode("Chatbox");
        chatLog = root.GetNode<RichTextLabel>("VBoxContainer/chatLog");
        label = root.GetNode<Label>("VBoxContainer/HBoxContainer/Label");
        lineEdit = root.GetNode<LineEdit>("VBoxContainer/HBoxContainer/LineEdit");
        lineEdit.Connect("text_entered", this, "_TextEntered");

        // Create key, values for the categories dictionnary
        categories.Add("Group", "#2FC3FF");
        categories.Add("Say", "#FFFFFF");
        categories.Add("Global", "#E8D22B");

    }

    public override void _Input(InputEvent inputEvent)
    {
        if (inputEvent is InputEventKey keyEvent && keyEvent.Pressed)
        {
            if ((KeyList)keyEvent.Scancode == KeyList.Enter)
            {   
                lineEdit.GrabFocus();
            }
            else if ((KeyList)keyEvent.Scancode == KeyList.Escape)
            {
                lineEdit.ReleaseFocus();
            }
        }
    }

    public void _AddMessage(string name, string text, string groupName="Say")
    {   
        // Set Color
        string textSend = "[color="+ categories[groupName]+"]";
        // Add a Name
        textSend += "[b]"+name +"[/b] : ";
        // Put Text
        textSend += text +"\n";
        chatLog.AppendBbcode(textSend);
    }

    public void _TextEntered(string text)
    {
        lineEdit.Text = "";
        _AddMessage(userName, text);
    }



}
