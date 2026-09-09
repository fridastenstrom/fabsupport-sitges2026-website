import type { Metadata } from 'next'
import { Archivo, Inter } from 'next/font/google'
import './globals.css'

const headingFont = Archivo({
  subsets: ['latin'],
  weight: ['500', '600', '700', '800'],
  style: ['normal', 'italic'],
  variable: '--font-heading',
  display: 'swap',
})

const bodyFont = Inter({
  subsets: ['latin'],
  weight: ['400', '500', '600'],
  style: ['normal', 'italic'],
  variable: '--font-body',
  display: 'swap',
})

export const metadata: Metadata = {
  title: 'Sitges — FAB Support',
  description: 'Konferensresa till Sitges, 8–11 oktober 2026.',
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="sv">
      <body className={`${headingFont.variable} ${bodyFont.variable}`}>{children}</body>
    </html>
  )
}
