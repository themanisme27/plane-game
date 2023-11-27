import pygame
import random

# Initialize Pygame
pygame.init()

# Constants
WIDTH, HEIGHT = 600, 400
FPS = 60

# Colors
WHITE = (255, 255, 255)
RED = (255, 0, 0)

# Create the window
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Plane Game")

# Load images
plane_img = pygame.image.load('plane.png')
plane_img = pygame.transform.scale(plane_img, (50, 50))

enemy_img = pygame.Surface((50, 50))
enemy_img.fill(RED)

# Game variables
player_x = 50
player_y = HEIGHT // 2
player_speed = 5

enemies = []
enemy_speed = 3
enemy_spawn_timer = 0

clock = pygame.time.Clock()

running = True
while running:
    # Event handling
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Player movement
    keys = pygame.key.get_pressed()
    if keys[pygame.K_UP]:
        player_y -= player_speed
    if keys[pygame.K_DOWN]:
        player_y += player_speed

    # Enemy spawning
    enemy_spawn_timer += 1
    if enemy_spawn_timer == FPS // 2:
        enemy_spawn_timer = 0
        enemy_y = random.randint(0, HEIGHT - 50)
        enemies.append([WIDTH, enemy_y])

    # Update enemies
    for enemy in enemies:
        enemy[0] -= enemy_speed

    # Check collision
    for enemy in enemies:
        if pygame.Rect(player_x, player_y, 50, 50).colliderect(pygame.Rect(enemy[0], enemy[1], 50, 50)):
            print("Game Over!")
            running = False

    # Draw
    screen.fill(WHITE)
    screen.blit(plane_img, (player_x, player_y))
    for enemy in enemies:
        screen.blit(enemy_img, (enemy[0], enemy[1]))

    pygame.display.flip()
    clock.tick(FPS)

pygame.quit()
