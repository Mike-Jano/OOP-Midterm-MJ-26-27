CREATE TYPE agent_type AS ENUM ('human', 'zombie');

CREATE TABLE IF NOT EXISTS agents (
    agent_id SERIAL PRIMARY KEY,
    agent_type agent_type NOT NULL,

    is_alive BOOLEAN NOT NULL DEFAULT TRUE,
    current_interation INTEGER NOT NULL DEFAULT 0 CHECK (current_interation >= 0),
    
    health INTEGER NOT NULL DEFAULT 100 CHECK (health >= 0 AND health <= 200),
    speed INTEGER NOT NULL DEFAULT 5 CHECK (speed >= 1 AND speed <= 10),

    UNIQUE (agent_id, agent_type)
);

CREATE TABLE IF NOT EXISTS humans (
    agent_id INTEGER PRIMARY KEY,
    agent_type agent_type NOT NULL DEFAULT 'human' CHECK (agent_type = 'human'),

    weapon_tier INTEGER NOT NULL DEFAULT 1 CHECK (weapon_tier >= 1 AND weapon_tier <= 10),

    x_pos INTEGER NOT NULL DEFAULT 0 CHECK (x_pos >= -100 AND x_pos <= 100),
    y_pos INTEGER NOT NULL DEFAULT 0 CHECK (y_pos >= -100 AND y_pos <= 100),

    CONSTRAINT human_agent_fk
        FOREIGN KEY (agent_id, agent_type)
        REFERENCES agents (agent_id, agent_type)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS zombies (
    agent_id INTEGER PRIMARY KEY,
    agent_type agent_type NOT NULL DEFAULT 'zombie' CHECK (agent_type = 'zombie'),

    strength INTEGER NOT NULL DEFAULT 1 CHECK (strength >= 1 AND strength <= 10),

    x_pos INTEGER NOT NULL DEFAULT 0 CHECK (x_pos >= -100 AND x_pos <= 100),
    y_pos INTEGER NOT NULL DEFAULT 0 CHECK (y_pos >= -100 AND y_pos <= 100),

    CONSTRAINT zombie_agent_fk
        FOREIGN KEY (agent_id, agent_type)
        REFERENCES agents (agent_id, agent_type)
        ON DELETE CASCADE
);
