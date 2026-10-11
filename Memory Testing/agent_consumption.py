from dataclasses import dataclass
from pympler import asizeof

# The "slots=True" placed after all of the @dataclass's helps reduce the memory taken up by the agents even more. 
# Prior to the addition of this parameter, each agent was taking up approximately 850 bytes.
# Try it yourself if you like by removing the parameter as a whole.

@dataclass(slots=True)
class Agent:
    agent_id: int
    agent_type: str
    is_alive: bool
    speed: int
    health: int


@dataclass(slots=True)
class Human(Agent):
    weapon_tier: int
    x_pos: int
    y_pos: int


@dataclass(slots=True)
class Zombie(Agent):
    strength: int
    x_pos: int
    y_pos: int


human1 = Human(agent_id=1, agent_type="Human", is_alive=True,
               speed=5, health=100, weapon_tier=2)
zombie1 = Zombie(agent_id=200, agent_type="Zombie", is_alive=True,
                 speed=3, health=80, strength=4)

print(f"Human: {asizeof.asizeof(human1)} B")
print(f"Zombie: {asizeof.asizeof(zombie1)} B")
