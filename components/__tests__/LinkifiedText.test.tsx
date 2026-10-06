import { describe, it, expect } from 'vitest'
import { render, screen } from '@testing-library/react'
import LinkifiedText from '@/components/LinkifiedText'

describe('LinkifiedText', () => {
  it('renders plain text unchanged', () => {
    const { container } = render(<LinkifiedText text="Samling i lobbyn" />)
    expect(container.textContent).toBe('Samling i lobbyn')
    expect(container.querySelector('a')).toBeNull()
  })

  it('turns a bare URL into a link that opens in a new tab', () => {
    render(<LinkifiedText text="Karta: https://maps.app.goo.gl/abc123 här" />)
    const link = screen.getByRole('link', { name: 'https://maps.app.goo.gl/abc123' })
    expect(link).toHaveAttribute('href', 'https://maps.app.goo.gl/abc123')
    expect(link).toHaveAttribute('target', '_blank')
    expect(link).toHaveAttribute('rel', 'noopener noreferrer')
  })

  it('keeps trailing punctuation outside the link', () => {
    render(<LinkifiedText text="Se https://example.com/a." />)
    expect(screen.getByRole('link')).toHaveAttribute('href', 'https://example.com/a')
  })

  it('supports [label](url) links', () => {
    const { container } = render(<LinkifiedText text="Restaurang [Hitta hit](https://maps.app.goo.gl/xyz) i hamnen" />)
    const link = screen.getByRole('link', { name: 'Hitta hit' })
    expect(link).toHaveAttribute('href', 'https://maps.app.goo.gl/xyz')
    expect(container.textContent).toBe('Restaurang Hitta hit i hamnen')
  })

  it('does not link non-http schemes', () => {
    const { container } = render(<LinkifiedText text="[klick](javascript:alert(1))" />)
    expect(container.querySelector('a')).toBeNull()
  })
})
