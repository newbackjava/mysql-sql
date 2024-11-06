CREATE TABLE player (
                        `id` VARCHAR(100) NOT NULL,
                        `email` VARCHAR(30) NOT NULL,
                        `name` VARCHAR(20) NOT NULL,
                        `birthday` DATE NOT NULL,
                        `created_at` DATETIME NOT NULL DEFAULT now(),
                        `created_at_raw` TIMESTAMP NOT NULL DEFAULT now(),
                        PRIMARY KEY (`id`),
                        UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE
);

create table Champion(
                         id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
                         position varchar(20) not null,
                         win_ratio double not null,
                         pick_ratio double not null,
                         ban_ratio double not null
);

CREATE TABLE recentgame (
                            `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
                            `kill` INT NULL,
                            `death` INT NULL,
                            `assist` INT NULL,
                            `cs` INT NULL,
                            `avg_tier` VARCHAR(20) NULL DEFAULT 'iron',
                            `player_id` VARCHAR(100) NOT NULL,
                            `champion_id` INT NOT NULL,
                            UNIQUE INDEX `avg_tier_UNIQUE` (`avg_tier` ASC) VISIBLE,
                            UNIQUE INDEX `player_id_UNIQUE` (`player_id` ASC) VISIBLE,
                            UNIQUE INDEX `champion_id_UNIQUE` (`champion_id` ASC) VISIBLE,
                            CONSTRAINT `player_id_fk`
                                FOREIGN KEY (`player_id`)
                                    REFERENCES `player` (`id`)
                                    ON DELETE NO ACTION
                                    ON UPDATE NO ACTION,
                            CONSTRAINT `champion_id_fk`
                                FOREIGN KEY (`champion_id`)
                                    REFERENCES `champion` (`id`)
                                    ON DELETE NO ACTION
                                    ON UPDATE NO ACTION
);

insert into player(id, email, name, birthday)
values('000-000', 'asdf@gmail.com', '유저1', '2000-01-01');
select * from player;

insert into champion(position, win_ratio, pick_ratio, ban_ratio)
values('mid', 0.5, 0.32, 0.2);
select * from champion;

insert into recentgame(`kill`, death, assist, cs, player_id, champion_id)
values(10, 6, 8, 2, '000-000', 1);
select * from recentgame;