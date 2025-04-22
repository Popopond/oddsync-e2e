
import { test, expect } from '@playwright/test';

test('test', async ({ page }) => {
  await page.goto('https://meeting-room-booking-b3l0.onrender.com/users/sign_in');
  await page.getByRole('textbox', { name: 'Email' }).click();
  await page.getByRole('textbox', { name: 'Email' }).fill('');
  await page.getByRole('textbox', { name: 'Email' }).press('CapsLock');
  await page.getByRole('textbox', { name: 'Email' }).fill('test1@gmail.com');
  await page.getByRole('textbox', { name: 'Password' }).click();
  await page.getByRole('textbox', { name: 'Password' }).fill('12345678a');
  await page.getByRole('button', { name: 'Sign in' }).click();
  await page.getByRole('alert').locator('div').click();
  await page.getByText('เข้าสู่ระบบสำเร็จ Close').click();
});