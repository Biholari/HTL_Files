#include <fstream>
#include <iostream>
#include <stdexcept>
// Platz für Includes

#include "sokoban.h"

Sokoban::Sokoban(sf::RenderWindow &_window) : window(_window)
{
    if (!texture.loadFromFile("../data/Sokoban.png"))
        throw std::runtime_error("Could not load resource file");

    sprite_wall.setTexture(texture);
    sprite_wall.setTextureRect(sf::IntRect(128, 0, 64, 64));
    sprite_box.setTexture(texture);
    sprite_box.setTextureRect(sf::IntRect(0, 0, 64, 64));
    sprite_target.setTexture(texture);
    sprite_target.setTextureRect(sf::IntRect(64, 64, 64, 64));
    sprite_floor.setTexture(texture);
    sprite_floor.setTextureRect(sf::IntRect(0, 64, 64, 64));
    sprite_goal.setTexture(texture);
    sprite_goal.setTextureRect(sf::IntRect(64, 0, 64, 64));
    sprite_player[Direction::LEFT].setTexture(texture);
    sprite_player[Direction::LEFT].setTextureRect(sf::IntRect(64, 192, 64, 64));
    sprite_player[Direction::RIGHT].setTexture(texture);
    sprite_player[Direction::RIGHT].setTextureRect(sf::IntRect(0, 128, 64, 64));
    sprite_player[Direction::UP].setTexture(texture);
    sprite_player[Direction::UP].setTextureRect(sf::IntRect(0, 192, 64, 64));
    sprite_player[Direction::DOWN].setTexture(texture);
    sprite_player[Direction::DOWN].setTextureRect(sf::IntRect(64, 128, 64, 64));

    if (!font.loadFromFile("../data/GistLight.otf"))
        throw std::runtime_error("Could not load font file");

    text.setFont(font);
    text.setFillColor(sf::Color::Red);
    text.setCharacterSize(30);
}

void Sokoban::draw_block(Block &b)
{
    sf::Sprite block;
    switch (b.type)
    {
    case Block_Type::BOX:
        block = sprite_box;
        break;
    case Block_Type::WALL:
        block = sprite_wall;
        break;
    case Block_Type::TARGET:
        block = sprite_target;
        break;
    case Block_Type::FLOOR:
        block = sprite_floor;
        break;
    case Block_Type::GOAL:
        block = sprite_goal;
        break;
    case Block_Type::PLAYER:
        block = sprite_player[player_dir];
        break;
    }
    int pos_x = b.x * 64 - (player.x > 8 ? (player.x - 9) * 64 : -64);
    int pos_y = b.y * 64 - (player.y > 6 ? (player.y - 7) * 64 : -64);
    if (pos_y > 0 && pos_x > 0)
    {
        block.setPosition(pos_x, pos_y);
        window.draw(block);
    }
}

void Sokoban::key_pressed(sf::Keyboard::Key k)
{
    switch (k)
    {
    case sf::Keyboard::Left:

        break;
    case sf::Keyboard::Right:

        break;
    case sf::Keyboard::Up:

        break;
    case sf::Keyboard::Down:

        break;
    }
}

void Sokoban::key_released(sf::Keyboard::Key k)
{
    if (is_level_finished())
    {
        load_level();
        return;
    }
    switch (k)
    {
    case sf::Keyboard::Left:
        move_player(Direction::LEFT);
        break;
    case sf::Keyboard::Right:
        move_player(Direction::RIGHT);
        break;
    case sf::Keyboard::Up:
        move_player(Direction::UP);
        break;
    case sf::Keyboard::Down:
        move_player(Direction::DOWN);
        break;
    case sf::Keyboard::A:
        move_player(Direction::LEFT);
        break;
    case sf::Keyboard::D:
        move_player(Direction::RIGHT);
        break;
    case sf::Keyboard::W:
        move_player(Direction::UP);
        break;
    case sf::Keyboard::S:
        move_player(Direction::DOWN);
        break;
    }
}

void Sokoban::move_player(Direction dir)
{
    int new_x = player.x;
    int new_y = player.y;
    switch (dir)
    {
    case Direction::LEFT:
        new_x--;
        break;
    case Direction::RIGHT:
        new_x++;
        break;
    case Direction::DOWN:
        new_y++;
        break;
    case Direction::UP:
        new_y--;
        break;
    }
    if (can_move(new_x, new_y) || (is_box(new_x, new_y) && move_box(new_x, new_y, dir)))
    {
        // Move the player
        player.x = new_x;
        player.y = new_y;
        player_dir = dir;
    }
}

bool Sokoban::move_box(int x, int y, Direction dir)
{
    int new_x = x;
    int new_y = y;

    switch (dir)
    {
    case Direction::LEFT:
        new_x--;
        break;
    case Direction::RIGHT:
        new_x++;
        break;
    case Direction::DOWN:
        new_y++;
        break;
    case Direction::UP:
        new_y--;
        break;
    }

    for (auto &block : blocks)
    {
        if (block.x == x && block.y == y && block.type == Block_Type::BOX)
        {
            if (can_move(new_x, new_y))
            {
                block.x = new_x;
                block.y = new_y;
                return true;
            }
            else
            {
                return false;
            }
        }
    }

    return false;
}

bool Sokoban::is_box(int x, int y)
{
    for (auto it : blocks)
    {
        if (it.x == x && it.y == y)
        {
            if (it.type == Block_Type::BOX)
                return true;
        }
    }
    return false;
}

bool Sokoban::has_target(int x, int y)
{
    for (auto it : blocks)
    {
        if (it.x == x && it.y == y)
        {
            if (it.type == Block_Type::TARGET)
                return true;
        }
    }
    return false;
}

bool Sokoban::can_move(int x, int y)
{
    for (auto it : blocks)
    {
        if (it.x == x && it.y == y)
        {
            if (it.type == Block_Type::WALL)
                return false;
            if (it.type == Block_Type::BOX)
                return false;
        }
    }
    return true;
}

/**
 * @param # fügt einen Wand-Block ein
 * @param @ fügt einen Boden-Block ein und setzt die Postion des player-Blocks auf diese Position
 * @param $ fügt einen Boden-Block und einen Kisten-Block ein
 * @param . fügt einen Ziel-Block ein
 * @param * fügt einen Ziel-Block und einem Kisten-Block ein
 * @param + fügt einen Ziel-Block ein und setzt die Postion des player-Blocks auf diese Position eine Leerstelle fügt
 * einen Boden-Block ein
 */
void Sokoban::draw()
{
    window.clear();

    text.setString("Title: " + title);
    text.setPosition(50, 10);
    window.draw(text);
    text.setString("Level: " + std::to_string(current_level));
    text.setPosition(400, 10);
    window.draw(text);

    for (auto it = this->blocks.begin(); it != this->blocks.end(); ++it)
    {
        if (it->type == FLOOR || it->type == WALL)
        {
            Sokoban::draw_block(*it);
        }
    }

    for (auto it = this->blocks.begin(); it != this->blocks.end(); ++it)
    {
        if (it->type == TARGET)
        {
            Sokoban::draw_block(*it);
        }
    }

    for (auto it = this->blocks.begin(); it != this->blocks.end(); ++it)
    {
        if (it->type == BOX)
        {
            int y = it->y;
            if (Sokoban::has_target(it->x, y))
            {
                it->type = GOAL;
                Sokoban::draw_block(*it);
                it->type = BOX;
            }
            else
            {
                Sokoban::draw_block(*it);
            }
        }
    }

    // Draw the player block
    draw_block(player);

    window.display();
}

void Sokoban::start()
{
    std::string xml = "";

    // Open the XML file for reading
    std::ifstream level_file("../data/Boxxle1.slc");
    if (!level_file.is_open())
    {
        throw std::runtime_error("Could not open level file");
    }
    std::string line;
    while (std::getline(level_file, line))
    {
        xml += line;
    }
    level_file.close();

    // Find the Title tag in the xml string
    size_t title_start = find_first_xml_tag(xml, "Title", 0, true);
    size_t title_end = find_first_xml_tag(xml, "/Title", title_start, false);

    // Find the Title tag in the xml string
    this->title = xml.substr(title_start, title_end - title_start);

    // Find the LevelCollection tag in the xml string
    size_t level_start = find_first_xml_tag(xml, "LevelCollection", 0, true);

    // Find the first Level tag in the LevelCollection
    size_t level_end = 0;
    while (level_end != std::string::npos && level_start != std::string::npos)
    {
        level_start = find_first_xml_tag(xml, "Level", level_start + 1, true);
        if (level_start != std::string::npos)
        {
            level_end = find_first_xml_tag(xml, "/Level", level_start, false);
            this->levels.push_back(xml.substr(level_start, level_end - level_start));
        }
    }

    load_level();
}

/**
 * @brief Die Funktion ermittelt die Position des ersten passenden XML-Tags aus dem String
 *
 * @param xml Komplette XML Datei als String
 * @param tag Gesuchter Tag nach dem `<` "<Tag>"
 * @param offset Offset ab dem gesucht werden soll
 * @param after_tag Es gibt ein `</Tag>`
 * @return size_t Index des ersten Zeichens nach dem Tag
 */
size_t Sokoban::find_first_xml_tag(std::string xml, std::string tag, size_t offset, bool after_tag)
{
    size_t pos = xml.find("<" + tag, offset);
    if (pos == std::string::npos)
    {
        return std::string::npos;
    }
    if (after_tag)
    {
        pos += tag.length() + 1;
        size_t end_pos = xml.find(">", pos);
        if (end_pos == std::string::npos)
        {
            return std::string::npos;
        }
        return end_pos + 1;
    }
    return pos;
}

void Sokoban::load_level()
{
    std::string level = this->levels[current_level];
    this->levels.erase(this->levels.begin());

    ++current_level;

    blocks.clear();

    int line = 0;
    size_t l = 0;
    size_t l_end;

    while (l != -1)
    {
        Block b;

        l = find_first_xml_tag(level, "L", l, 1);
        l_end = find_first_xml_tag(level, "/L", l + 1, 0);

        if (l != -1)
        {
            std::string symbols = level.substr(l, l_end - l);

            for (int i = 0; i < symbols.length(); ++i)
            {
                b.x = i;
                b.y = line;

                switch (symbols[i])
                {
                case ' ':
                    b.type = FLOOR;
                    this->blocks.push_back(b);
                    break;
                case '#':
                    b.type = WALL;
                    this->blocks.push_back(b);
                    break;
                case '$':
                    b.type = BOX;
                    this->blocks.push_back(b);
                    b.type = FLOOR;
                    this->blocks.push_back(b);
                    break;
                case '*':
                    b.type = TARGET;
                    this->blocks.push_back(b);
                    b.type = BOX;
                    this->blocks.push_back(b);
                    break;
                case '+':
                    b.type = TARGET;
                    this->blocks.push_back(b);
                    this->player.x = i;
                    this->player.y = line;
                    break;
                case '.':
                    b.type = TARGET;
                    this->blocks.push_back(b);
                    break;
                case '@':
                    this->player.x = i;
                    this->player.y = line;
                    b.type = FLOOR;
                    this->blocks.push_back(b);
                    break;
                default:
                    continue;
                }
            }

            symbols.clear();
        }

        ++line;
    }

    level.clear();
}

bool Sokoban::is_level_finished()
{
    // Prüfen ob an der Position jedes Targets eine Box ist
    int y;

    for (auto it = blocks.begin(), end = blocks.end(); it != end; ++it)
    {
        if (it->type == BOX)
        {
            y = it->y;
            if (!has_target(it->x, y))
                return 0;
        }
    }
    return 1;
}