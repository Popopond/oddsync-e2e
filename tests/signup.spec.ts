import { test, expect } from '@playwright/test';

test.describe('Signup Tests', () => {
  test('should successfully sign up a new user', async ({ page }) => {
    await page.goto('https://meeting-room-booking-b3l0.onrender.com/users/sign_in');
    
    await page.getByRole('link', { name: 'Create new account' }).click();
    
    await page.getByRole('textbox', { name: 'Username' }).fill('test1');
    await page.getByRole('textbox', { name: 'Email' }).fill('test1@gmail.com');
    await page.getByRole('textbox', { name: 'Password', exact: true }).fill('12345678a');
    await page.getByRole('textbox', { name: 'Password confirmation' }).fill('12345678a');
    
    await page.getByRole('button', { name: 'Sign up' }).click();
    await expect(page).toHaveURL('https://meeting-room-booking-b3l0.onrender.com/users');
    });

});