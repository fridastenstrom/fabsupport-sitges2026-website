import { Fragment } from 'react'

// Matches [label](https://url) or a bare http(s) URL
const LINK_RE = /\[([^\]]+)\]\((https?:\/\/[^\s)]+)\)|(https?:\/\/[^\s<]+)/g
const TRAILING_PUNCT = /[.,;:!?)]+$/

function Anchor({ href, children }: { href: string; children: React.ReactNode }) {
  return (
    <a href={href} target="_blank" rel="noopener noreferrer" className="text-link">
      {children}
    </a>
  )
}

export default function LinkifiedText({ text }: { text: string }) {
  const parts: React.ReactNode[] = []
  let last = 0
  for (const m of text.matchAll(LINK_RE)) {
    const start = m.index ?? 0
    let end = start + m[0].length
    let node: React.ReactNode
    if (m[1]) {
      node = <Anchor href={m[2]}>{m[1]}</Anchor>
    } else {
      const url = m[3].replace(TRAILING_PUNCT, '')
      end = start + url.length
      node = <Anchor href={url}>{url}</Anchor>
    }
    if (start > last) parts.push(text.slice(last, start))
    parts.push(node)
    last = end
  }
  if (last < text.length) parts.push(text.slice(last))
  return (
    <>
      {parts.map((p, i) => (
        <Fragment key={i}>{p}</Fragment>
      ))}
    </>
  )
}
