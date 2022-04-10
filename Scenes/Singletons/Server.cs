using Godot;
using System;

public class Server : Node
{
    private int maxPlayer = 100;
    private string ip = "localhost";
    private readonly int port = 4321;
    private NetworkedMultiplayerENet network = new NetworkedMultiplayerENet();


    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        GD.Print("~~ Client creation");
        network.CreateClient(ip, port);
        GetTree().NetworkPeer = network;

        GD.Print("~~ Connect basic event");
        network.Connect("connection_failed", this, "_ConnectionFailed");
        network.Connect("connection_succeeded", this, "_ConnectionSucceeded");

    }

    public void _ConnectionFailed()
    {
        GD.Print("Connection to: "+ ip + ":" + port + "failed");
    }

    public void _ConnectionSucceeded()
    {
        GD.Print("Connection to: "+ ip + ":" + port + "Success");
    }

}
